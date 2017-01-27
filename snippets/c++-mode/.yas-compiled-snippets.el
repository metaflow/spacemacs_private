;;; Compiled snippets and support files for `c++-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'c++-mode
                     '(("alg_binary_search_lower" "// invariant: answer is within (a, b], f(a) = false, f(b) = true\n${1:l} binary_search_lower($1 a, $1 b, function<bool($1)> f) {\n  while (b - a > 1) {\n    $1 m = (a + b) / 2;\n    if (f(m)) {\n      b = m;\n    } else {\n      a = m;\n    }\n  }\n  return b;\n}\n" "alg_binary_search_lower" nil nil nil "c:/Users/mgoncharov/.emacs.d/private/snippets/c++-mode/alg_binary_search_lower" nil nil)))


;;; Do not edit! File generated at Thu Jan 26 08:50:43 2017
