import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { CustomValidationPipe } from './pipes/validation.pipe';
import { initFolder } from './utils/file';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(new CustomValidationPipe());
  initFolder();
  await app.listen(8080);
}
bootstrap();
