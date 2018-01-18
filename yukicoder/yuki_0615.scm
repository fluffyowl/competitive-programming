(define nm (read (open-input-string (format "(~a)" (read-line)))))
(define n (car nm))
(define m (cadr nm))
(define a (sort (read (open-input-string (format "(~a)" (read-line)))) <)) 

(define (diff n lst) (if (= n 1) '() (cons (- (cadr lst) (car lst)) (diff (- n 1) (cdr lst)))))
(define b (diff n a))

(print (- (fold + 0 b) (fold + 0 (take (sort b >) (- m 1)))))
