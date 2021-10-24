;; -*- lexical-binding: t; -*-

(load "test/helpers.el")
(require 'org-gtd)
(require 'buttercup)
(require 'with-simulated-input)

(describe
 "Create a default file when there isn't a refile target"

 (before-all (ogt--configure-emacs))
 (before-each (ogt--clean-target-directory org-gtd-directory))
 (after-each (ogt--close-and-delete-files))

 (it "for a project"
     (ogt--add-and-process-project "project headline")
     (with-simulated-input "!" (save-some-buffers))
     (list-directory org-gtd-directory)
     (with-current-buffer "*Directory*"
       (expect (buffer-string)
               :to-match
               ".*projects\\.org.*"))
     (kill-buffer "*Directory*"))

 (it "for a scheduled item"
     (ogt--add-and-process-scheduled-item "scheduled headline")
     (with-simulated-input "!" (save-some-buffers))
     (list-directory org-gtd-directory)
     (with-current-buffer "*Directory*"
       (expect (buffer-string)
               :to-match
               ".*scheduled\\.org.*"))
     (kill-buffer "*Directory*")))
