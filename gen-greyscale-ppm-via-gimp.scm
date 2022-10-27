(define (foreach n action)
  (let ((i 0))
    (while (< i n)
      (set! i (+ i 1))
      (action i))))

(define (new-fullsize)
  (car
    (gimp-file-load
      RUN-NONINTERACTIVE
      "Ada_Lovelace_portrait.ppm"
      "Ada_Lovelace_portrait.ppm")))

(define (autoscale-height image width)
  (inexact->exact
    (ceiling
      (* width
        (/
          (car (gimp-image-height image))
          (car (gimp-image-width image)))))))

(define (autoscale image width)
  (gimp-image-scale image width (autoscale-height image width)))

(define (make-2-bit image)
  (gimp-image-convert-indexed image
    CONVERT-DITHER-FS-LOWBLEED
    CONVERT-PALETTE-MONO
    2 ;ignored
    FALSE
    TRUE
    "" ;ignored
    ))

(define (save image name)
  (gimp-file-save
    RUN-NONINTERACTIVE
    image
    (car (gimp-image-get-active-layer image))
    name
    name))

(define (resize-bw width)
  (let*
    ((image (new-fullsize))
     (outfile (string-append "out-" (number->string width) ".ppm")))
    (print (string-append "Generating: " outfile))
    (autoscale image width)
    (make-2-bit image)
    (save image outfile)
    (gimp-image-delete image)))

(gimp-context-set-interpolation INTERPOLATION-CUBIC)
