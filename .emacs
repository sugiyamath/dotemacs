;; パッケージ管理システム（package.el）の設定
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; パッケージの自動インストール
(defvar my/packages
  '(company
    cyberpunk-theme
    web-mode
    emmet-mode))

(let ((not-installed
       (cl-loop for x in my/packages
                when (not (package-installed-p x))
                collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))

;; Pythonの設定
(defun python-autopep8 ()
  "Run autopep8 on current Python buffer."
  (interactive)
  (when (eq major-mode 'python-mode)
    (shell-command-on-region (point-min) (point-max)
			     "autopep8 -" nil t)))
(with-eval-after-load 'python
    (define-key python-mode-map (kbd "C-c C-r") 'python-autopep8))

(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-capf))

;; Web開発の設定
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))

(defun my/web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my/web-mode-hook)

;; Emmet-modeの設定
(require 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)

;; テーマの設定
(load-theme 'cyberpunk t)
