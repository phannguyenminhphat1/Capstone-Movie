import { Injectable, InternalServerErrorException } from '@nestjs/common';
import * as nodemailer from 'nodemailer';
import SMTPTransport from 'nodemailer/lib/smtp-transport';

@Injectable()
export class MailService {
  private transporter: nodemailer.Transporter<SMTPTransport.SentMessageInfo>;
  constructor() {
    this.transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: process.env.EMAIL,
        pass: process.env.PASS,
      },
    });
  }
  async sendMail(to: string, subject: string, text: string): Promise<void> {
    const mailOptions = {
      from: process.env.EMAIL,
      to,
      subject,
      text,
    };

    try {
      await this.transporter.sendMail(mailOptions);
    } catch (error) {
      throw new InternalServerErrorException(error);
    }
  }
}
