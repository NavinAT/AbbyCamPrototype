export interface ILocalizedStrings {
  /** error message: incorrect capture parameter (user options) */
  capture_param_error?: string;
  /** error message: no access to camera or no camera */
  camera_error?: string;
  /** error message: camera is disabled in the API settings */
  camera_disabled?: string;
  /** error message: camera stream resolution is less than 1000 by lowest dimension */
  camera_low_res?: string;
  /** error message: camera stream resolution is less than by lowest dimension on IOS (IOS version < 12.2) */
  camera_low_res_ios?: string;
  /** prompt message shown when camera should be moved closer to document */
  camera_alert_closer?: string;
  /** prompt message shown when document is being detected */
  camera_alert_searching?: string;
  /** a quick message is displayed when a dirty camera is detected */
  camera_alert_sharpness_filter?: string;
  /** loading module message */
  app_loading?: string;
  /** default error from wasm module message */
  wasm_error?: string;
  /** failure of license error */
  wasm_license_error?: string;
  /** image processing by wasm message */
  image_processing?: string;
  /** pop-up title for the use autocapture option */
  use_autocapture_title?: string;
  /** pop-up message for the use autocapture option */
  use_autocapture_text?: string;
  /** text on the button for continuing autocapture */
  continue?: string;
  /** pop-up title for warning about image low quality */
  low_quality_title?: string;
  /** pop-up message for warning about image low quality */
  low_quality_text?: string;
  /** pop-up title for warning that wasm cannot detect image boundaries */
  crop_boundaries_not_found_title?: string;
  /** pop-up message for warning that wasm cannot detect image boundaries */
  crop_boundaries_not_found_text?: string;
  /** error on EDGE browser in autocapture mode message */
  browser_edge_error?: string;
  /** error on NON SAFARI browser in autocapture mode message */
  ios_non_safari_error?: string;
  /** text on the add page button */
  add_page: string;
  /** text on the done page button text */
  done: string;
  /** text line for pointing current page (i.e. 'Page #') */
  page: string;
  /** text line for pointing current page and pages amount (i.e. 'Page # of #') */
  of: string;
  /** text on the delete button */
  delete: string;
  /** text on the Retake image button */
  retake: string;
  /** text on the Manual Crop button */
  crop: string;
  /** text on the Rotate image button */
  rotate: string;
  /** text on the Cancel crop button */
  cancel: string;
  /** text on the Apply crop button */
  apply: string;
  /** Common part of compound message shown if defined aspect ratio does not match found document size */
  waitingFor: string;
  /** Shown after waitingFor message if documentSize is set to ID constant and does not match found document size */
  ID: string;
  /** Shown after waitingFor message if documentSize is set to A4 constant and and does not match found document size */
  A4: string;
  /** Shown after waitingFor message if documentSize is set to letter constant and does not match found document size */
  letter: string;
  /** general error message: aspect ratio mismatch. Shown if documentSize constant is not defined */
  incorrectAspectRatio: string;
}

/** Crop Point */
export type IPoint = {
  x: number;
  y: number;
};

/** all posible verdicts of estimator */
export enum SuitabilityForOcrVerdict {
  SFOV_TotalyBad,
  SFOV_Good,
  SFOV_GoodWithPossibleErrors,
  SFOV_ManyErrors,
}

export type IDocumentSizeType = 'A4' | 'letter' | 'ID-1' | 'ID-2' | 'ID-3';

/** results from estimator */
export type TQualityAssessmentResult = {
  verdict: SuitabilityForOcrVerdict;
  /** confidence that document is good 0-1 */
  confidence: number;
};

/** Image result to external user */
export interface ICaptureExternalResult {
  originalImage: string; // base64 image string
  /** crop points */
  documentBoundary: IPoint[];
  capturedImage: string; // base64 image string
  /** document quality */
  ocrQuality?: TQualityAssessmentResult;
}

/** external interface of MWC init method */
export interface IWebCaptureInitOptions {
  /** path where license file is placed */
  licenseFilePath?: string;
  /** folder where all wasm files are placed */
  wasmFilesPath?: string;
  /** override default messages with custom ones */
  localizedStrings?: ILocalizedStrings;
}

export interface IWebCaptureOptions extends IWebCaptureInitOptions {
  /** minimal aspect ratio of searched document, 0.0 or >= 1.0 */
  aspectRatioMin?: number;
  /** maximal aspect ratio of searched document, 0.0 or >= 1.0. Also should be >= aspectRatioMin */
  aspectRatioMax?: number;
  documentSize?: IDocumentSizeType;
  /** result jpeg quality, 0-100 */
  jpegQuality?: number;
  /** number of page to show on load */
  startPage?: number;
  /** max number of attached documents */
  maxImagesCount?: number;
  /** is camera enabled */
  enableCamera?: boolean;
  /** process and capture camera stream */
  enableAutoCapture?: boolean;
  /** enable wasm autocrop */
  enableAutoCrop?: boolean;
  /** enable wasm quality detection */
  enableQualityAssessmentForOCR?: boolean;
  /**
   *  percentage, all four corners must be withing %frameBoundaryPadding% pct padding from screen edges
   *  50% - corners can be anywhere(50% from each side = whole screen), 1% - corners must be strictly
   *  within 1% from screen corners (almost impossible case)
   */
  frameBoundaryPadding?: number;
  /** Requirements for camera resolution.
   *  If camera dimension < MIN_CAMERA_RESOLUTION by lowest size, prevent from using it (because documents can't be
   *  recognized)
   */
  minCameraResolution?: number;
  /** Preferred camera resolution, default is Auto */
  preferredCameraResolution?: string;
  /** enable sharpness filter */
  enableSharpnessFilter?: boolean;
}

/** external interface of MWC capture method */
export interface IWebCaptureInterface extends IWebCaptureOptions {
  /** previously stored images */
  images?: ICaptureExternalResult[];
}
