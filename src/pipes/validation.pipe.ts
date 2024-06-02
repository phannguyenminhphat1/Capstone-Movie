import {
  ArgumentMetadata,
  Injectable,
  PipeTransform,
  BadRequestException,
} from '@nestjs/common';
import { validate } from 'class-validator';
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
    for (const key in errors) {
      const { constraints, property } = errors[key];
      const message = Object.values(constraints);
      objErrors[property] = message[0];
    }

    if (errors.length > 0) {
      throw new BadRequestException({
        message: USERS_MESSAGES.VALIDATION_ERROR,
        errors: objErrors,
      });
    }
    return value;
  }
  private toValidate(metatype: Function): boolean {
    const types: Function[] = [String, Boolean, Number, Array, Object];
    return !types.includes(metatype);
  }
}
