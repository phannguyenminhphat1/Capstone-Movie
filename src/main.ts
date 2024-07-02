import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { CustomValidationPipe } from './pipes/validation.pipe';
import { initFolder } from './utils/file';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { HttpInternalExceptionFilter } from './utils/exceptions/http-exception.filter';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  initFolder();
  app.useGlobalPipes(new CustomValidationPipe());
  const config = new DocumentBuilder()
    .setTitle('Movie API')
    .setDescription('API documentation for the Movie API')
    .setVersion('1.0')
    .addBearerAuth()
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('swagger', app, document);
  app.useGlobalFilters(new HttpInternalExceptionFilter());
  await app.listen(8080);
}
bootstrap();
