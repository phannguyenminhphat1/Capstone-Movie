import {
  ArgumentMetadata,
  Injectable,
  PipeTransform,
  UnprocessableEntityException,
} from '@nestjs/common';
import { validate, ValidationError } from 'class-validator';
import { plainToInstance } from 'class-transformer';
import { USERS_MESSAGES } from 'src/constants/messages';

@Injectable()
export class CustomValidationPipe implements PipeTransform<any> {
  async transform(value: any, { metatype }: ArgumentMetadata) {
    if (!metatype || !this.toValidate(metatype)) {
      return value;
    }
    const object = plainToInstance(metatype, value);
    const errors = await validate(object);
    const objErrors = {};
    for (const error of errors) {
      this.flattenValidationErrors(error, objErrors);
    }
    if (Object.keys(objErrors).length > 0) {
      throw new UnprocessableEntityException({
        message: USERS_MESSAGES.VALIDATION_ERROR,
        errors: objErrors,
      });
    }
    return value;
  }

  private flattenValidationErrors(
    error: ValidationError,
    objErrors: Record<string, any>,
  ) {
    const { constraints, property, children } = error;
    if (children && children.length > 0) {
      children.forEach((childError) => {
        this.flattenValidationErrors(childError, objErrors);
      });
    } else {
      objErrors[property] = Object.values(constraints)[0];
    }
  }

  private toValidate(metatype: Function): boolean {
    const types: Function[] = [String, Boolean, Number, Array, Object];
    return !types.includes(metatype);
  }
}
