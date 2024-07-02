import { COMMON_MESSAGES } from 'src/constants/messages';
import { UnprocessableEntityException } from './exceptions/unprocessable.exception';
import { UPLOAD_IMAGE_FOLDER } from './file';
import * as multer from 'multer';

export const uploadOptions = {
  storage: multer.diskStorage({
    destination: UPLOAD_IMAGE_FOLDER,
    filename: (req, file, callback) => {
      const imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'svg'];
      const extension = file.originalname.split('.').pop().toLowerCase();
      if (!imageExtensions.includes(extension)) {
        return callback(
          new UnprocessableEntityException(COMMON_MESSAGES.IMAGE_IS_NOT_VALID),
          '',
        );
      }
      let mSecond = new Date().getTime();
      callback(
        null,
        mSecond +
          '-' +
          Math.round(Math.random() * 189) +
          '_' +
          file.originalname,
      );
    },
  }),
};
