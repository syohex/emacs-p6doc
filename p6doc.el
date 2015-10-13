;;; p6doc.el --- Simple p6doc viewer

;; Copyright (C) 2015 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>
;; URL: https://github.com/syohex/
;; Version: 0.01

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; p6doc.el provide function which display Perl6 document with p6doc command.

;;; Code:

(defgroup p6doc nil
  "p6doc from Emacs"
  :group 'perl)

(defconst p6doc--builtin-types
  '("Type::AST"
    "Type::Any"
    "Type::Array"
    "Type::Associative"
    "Type::Attribute"
    "Type::Backtrace"
    "Type::Backtrace"
    "Type::Bag"
    "Type::BagHash"
    "Type::Baggy"
    "Type::Blob"
    "Type::Block"
    "Type::Bool"
    "Type::Buf"
    "Type::Callable"
    "Type::Capture"
    "Type::Channel"
    "Type::Code"
    "Type::Complex"
    "Type::Cool"
    "Type::CurrentThreadScheduler"
    "Type::Cursor"
    "Type::Date"
    "Type::DateTime"
    "Type::Dateish"
    "Type::Duration"
    "Type::Enum"
    "Type::EnumMap"
    "Type::Exception"
    "Type::Failure"
    "Type::FatRat"
    "Type::Grammar"
    "Type::Hash"
    "Type::IO"
    "Type::IO::Handle"
    "Type::IO::Notification"
    "Type::IO::Path"
    "Type::IO::Pipe"
    "Type::IO::Socket"
    "Type::IO::Socket::Async"
    "Type::IO::Socket::INET"
    "Type::IO::Spec"
    "Type::IO::Spec::Cygwin"
    "Type::IO::Spec::Unix"
    "Type::IO::Spec::Win32"
    "Type::Instant"
    "Type::Int"
    "Type::Iterable"
    "Type::Iterator"
    "Type::Junction"
    "Type::Label"
    "Type::List"
    "Type::Lock"
    "Type::Macro"
    "Type::Match"
    "Type::Metamodel::AttributeContainer"
    "Type::Metamodel::C3MRO"
    "Type::Metamodel::ClassHOW"
    "Type::Metamodel::Finalization"
    "Type::Metamodel::MROBasedMethodDispatch"
    "Type::Metamodel::MethodContainer"
    "Type::Metamodel::MultipleInheritance"
    "Type::Metamodel::Naming"
    "Type::Metamodel::Primitives"
    "Type::Metamodel::PrivateMethodContainer"
    "Type::Metamodel::RoleContainer"
    "Type::Metamodel::Trusting"
    "Type::Method"
    "Type::Mix"
    "Type::MixHash"
    "Type::Mixy"
    "Type::Mu"
    "Type::Nil"
    "Type::Num"
    "Type::Numeric"
    "Type::ObjAt"
    "Type::Pair"
    "Type::PairMap"
    "Type::Parameter"
    "Type::Pod::Block"
    "Type::Pod::Block::Code"
    "Type::Pod::Block::Named"
    "Type::Pod::Block::Para"
    "Type::Pod::Item"
    "Type::Positional"
    "Type::PositionalBindFailover"
    "Type::Proc"
    "Type::Proc::Async"
    "Type::Proc::Status"
    "Type::Promise"
    "Type::Proxy"
    "Type::QuantHash"
    "Type::Range"
    "Type::Rat"
    "Type::Rational"
    "Type::Real"
    "Type::Regex"
    "Type::Routine"
    "Type::Scheduler"
    "Type::Seq"
    "Type::Set"
    "Type::SetHash"
    "Type::Setty"
    "Type::Signature"
    "Type::Slip"
    "Type::Stash"
    "Type::Str"
    "Type::Stringy"
    "Type::Sub"
    "Type::Submethod"
    "Type::Supply"
    "Type::Tap"
    "Type::Temporal"
    "Type::Thread"
    "Type::ThreadPoolScheduler"
    "Type::Variable"
    "Type::Version"
    "Type::Whatever"
    "Type::WhateverCode"
    "Type::X::AdHoc"
    "Type::X::Anon::Augment"
    "Type::X::Anon::Multi"
    "Type::X::Assignment::RO"
    "Type::X::Attribute::NoPackage"
    "Type::X::Attribute::Package"
    "Type::X::Attribute::Undeclared"
    "Type::X::Augment::NoSuchType"
    "Type::X::Bind"
    "Type::X::Bind::NativeType"
    "Type::X::Bind::Slice"
    "Type::X::Channel::ReceiveOnClosed"
    "Type::X::Channel::SendOnClosed"
    "Type::X::Comp"
    "Type::X::Composition::NotComposable"
    "Type::X::Constructor::Positional"
    "Type::X::ControlFlow"
    "Type::X::ControlFlow::Return"
    "Type::X::Declaration::Scope"
    "Type::X::Declaration::Scope::Multi"
    "Type::X::Does::TypeObject"
    "Type::X::Eval::NoSuchLang"
    "Type::X::Export::NameClash"
    "Type::X::IO"
    "Type::X::IO::Chdir"
    "Type::X::IO::Chmod"
    "Type::X::IO::Copy"
    "Type::X::IO::Cwd"
    "Type::X::IO::Dir"
    "Type::X::IO::Mkdir"
    "Type::X::IO::Rename"
    "Type::X::IO::Rmdir"
    "Type::X::IO::Unlink"
    "Type::X::Inheritance::NotComposed"
    "Type::X::Inheritance::Unsupported"
    "Type::X::Method::InvalidQualifier"
    "Type::X::Method::NotFound"
    "Type::X::Method::Private::Permission"
    "Type::X::Method::Private::Unqualified"
    "Type::X::Mixin::NotComposable"
    "Type::X::NYI"
    "Type::X::NoDispatcher"
    "Type::X::Numeric::Real"
    "Type::X::OS"
    "Type::X::Obsolete"
    "Type::X::OutOfRange"
    "Type::X::Package::Stubbed"
    "Type::X::Parameter::Default"
    "Type::X::Parameter::MultipleTypeConstraints"
    "Type::X::Parameter::Placeholder"
    "Type::X::Parameter::Twigil"
    "Type::X::Parameter::WrongOrder"
    "Type::X::Phaser::Multiple"
    "Type::X::Phaser::PrePost"
    "Type::X::Placeholder::Block"
    "Type::X::Placeholder::Mainline"
    "Type::X::Pod"
    "Type::X::Proc::Async"
    "Type::X::Proc::Async::AlreadyStarted"
    "Type::X::Proc::Async::CharsOrBytes"
    "Type::X::Proc::Async::MustBeStarted"
    "Type::X::Proc::Async::OpenForWriting"
    "Type::X::Proc::Async::TapBeforeSpawn"
    "Type::X::Promise::CauseOnlyValidOnBroken"
    "Type::X::Redeclaration"
    "Type::X::Role::Initialization"
    "Type::X::Sequence::Deduction"
    "Type::X::Signature::NameClash"
    "Type::X::Signature::Placeholder"
    "Type::X::Str::Numeric"
    "Type::X::StubCode"
    "Type::X::Syntax"
    "Type::X::Syntax::AddCategorial::MissingSeparator"
    "Type::X::Syntax::Augment::Role"
    "Type::X::Syntax::Augment::WithoutMonkeyTyping"
    "Type::X::Syntax::Comment::Embedded"
    "Type::X::Syntax::Confused"
    "Type::X::Syntax::InfixInTermPosition"
    "Type::X::Syntax::Malformed"
    "Type::X::Syntax::Missing"
    "Type::X::Syntax::NegatedPair"
    "Type::X::Syntax::NoSelf"
    "Type::X::Syntax::Number::RadixOutOfRange"
    "Type::X::Syntax::P5"
    "Type::X::Syntax::Regex::Adverb"
    "Type::X::Syntax::Regex::SolitaryQuantifier"
    "Type::X::Syntax::Reserved"
    "Type::X::Syntax::Self::WithoutObject"
    "Type::X::Syntax::Signature::InvocantMarker"
    "Type::X::Syntax::Term::MissingInitializer"
    "Type::X::Syntax::UnlessElse"
    "Type::X::Syntax::Variable::Match"
    "Type::X::Syntax::Variable::Numeric"
    "Type::X::Syntax::Variable::Twigil"
    "Type::X::Temporal"
    "Type::X::Temporal::Truncation"
    "Type::X::TypeCheck"
    "Type::X::TypeCheck::Assignment"
    "Type::X::TypeCheck::Binding"
    "Type::X::TypeCheck::Return"
    "Type::X::TypeCheck::Splice"
    "Type::X::Undeclared"
    "Type::int"))

(defvar p6doc--history nil)

(defun p6doc--command (query)
  (when (get-buffer "*p6doc*")
    (with-current-buffer (get-buffer "*p6doc*")
      (erase-buffer)))
  (let* ((process-environment (cons "PAGER=cat" process-environment))
         (process (start-file-process "p6doc" (get-buffer-create "*p6doc*") "p6doc" query)))
    (set-process-sentinel
     process
     (lambda (proc _event)
       (when (eq (process-status proc) 'exit)
         (with-current-buffer (get-buffer "*p6doc*")
           (goto-char (point-min))
           (pop-to-buffer (current-buffer))))))))

;;;###autoload
(defun p6doc (query)
  (interactive
   (list (completing-read "Query> " p6doc--builtin-types nil nil nil 'p6doc--history)))
  (p6doc--command query))

(provide 'p6doc)

;;; p6doc.el ends here
