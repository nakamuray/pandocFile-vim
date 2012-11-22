==============
pandocFile.vim
==============

This plugin converts various markup formats at read/write time using pandoc_.

.. _pandoc: http://johnmacfarlane.net/pandoc/


Install
=======

Put ``autoload/pandocFile.vim`` into your ``~/.vim/autoload/``.


Configuration example
=====================

To use this plugin, you should define autocmds like below::

  autocmd BufReadCmd,FileReadCmd *.textile call pandocFile#Read(expand("<amatch>"), "textile", "rst")
  autocmd BufWriteCmd,FileWriteCmd *.textile call pandocFile#Write(expand("<amatch>"), "rst", "textile")

In this example, pandocFile allow you to edit textile markuped files as reStructuredText.

You can also use helper function to define autocmds::

  call pandocFile#DefAuto('*.textile', 'textile', 'rst')


If you intend to use it for redmine textile format, please
``let g:pandocFile_redmine_textile_workaround=1``
to activate workaround.
