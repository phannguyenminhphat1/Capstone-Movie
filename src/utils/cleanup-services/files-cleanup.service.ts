import { Injectable } from '@nestjs/common';
import * as fs from 'fs';
import * as path from 'path';
import { Cron } from '@nestjs/schedule';

@Injectable()
export class FileCleanupService {
  private readonly uploadImageFolder = path.resolve('public/img');

  @Cron('0 0 * * *')
  handleCron(): void {
    console.log('Deleted files in public/img...');
    this.deleteFilesInDirectory();
  }

  deleteFilesInDirectory(): void {
    fs.readdir(this.uploadImageFolder, (err, files) => {
      if (err) throw err;

      for (const file of files) {
        fs.unlink(path.join(this.uploadImageFolder, file), (err) => {
          if (err) throw err;
        });
      }
    });
  }
}
