#lang br/quicklang

#|(define (read-syntax path port)
  (define src-lines (port->lines port))
  (datum->syntax #f '(module lucy br
                       42)))
(provide read-syntax)|#


#|(define (read-syntax path port)
  (define src (port->string port))
  (datum->syntax #f (format-datum '(module module-name br "~a") src)))|#

(define new-source
  '(module
       module-name
     br
     (define out (open-output-file ~a #:exists 'replace))
     (display ~a out) #|"(set-logic QF_LIA)
(declare-const x Int)
(declare-const y Int)
(assert (= (- x y) (+ x (- y) 1)))
(check-sat)
; unsat
(exit)"|#
     (close-output-port out)
     
     (struct proc (stdout stdin))

     (define (start-program p)
       (define-values (s stdout stdin stderr) (subprocess #f #f #f p ~a))
       (thread (lambda () (copy-port stderr (current-error-port))))
       (proc stdout stdin))

     (define (send-to proc v)
       (write v (proc-stdin proc))
       (flush-output (proc-stdin proc)))

     (define (receive-from proc)
       (read (proc-stdout proc)))

     (parameterize ([current-command-line-arguments (vector ~a)])
       (define programs
         (map find-executable-path (vector->list (current-command-line-arguments))))
       (define running-programs
         (map start-program programs))
       (let loop ([x (receive-from (first running-programs))])
         (displayln x)
         (unless (eof-object? x)
           (loop (receive-from (first running-programs))))))))

(define (read-syntax path port)
  (define src (port->string port))
  (datum->syntax #f (format-datum new-source "\"./z3-input.txt\"" (string-append "\"" src "\"") "\"./z3-input.txt\""  "\"./z3\"")))


#|(define (read-syntax path port)
  (define src (port->string port))
  (datum->syntax #f new-source))|#

(provide read-syntax)