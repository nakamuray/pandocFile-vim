" ==============
" pandocFile.vim
" ==============
"
" This plugin converts various markup formats at read/write time.
"
"
" Configuration example
" =====================
"
" To use this plugin, you should define autocmds like below::
"
"   autocmd BufReadCmd *.textile call pandoc#Read(expand("<amatch>"), "textile", "rst")
"   autocmd FileReadCmd *.textile call pandoc#Read(expand("<amatch>"), "textile", "rst")
"   autocmd BufWriteCmd *.textile call pandoc#Write(expand("<amatch>"), "rst", "textile")
"   autocmd FileWriteCmd *.textile call pandoc#Write(expand("<amatch>"), "rst", "textile")
"
" If you intend to use it for redmine textile format, please
" ``let g:pandocFile_redmine_textile_workaround=1``
" to activate workaround.

function! pandocFile#Read(fname, from, to)
  if filereadable(a:fname)
    exe "silent read !pandoc -f " . a:from . " -t " . a:to . " " . shellescape(a:fname)

    " clean up
    0d
  endif
endfunction

function! pandocFile#Write(fname, from, to)
  if exists("g:pandocFile_redmine_textile_workaround") && a:to == "textile"
    " XXX: redmine textile escape special chars between <pre></pre>
    "      so, no need to escape by me
    exe "silent write !pandoc -f " . a:from . " -t " . a:to . " | sed -e '/<pre>/, /<\\/pre>/ { s/&quot;/\"/g; s/&lt;/</g; s/&gt;/>/g; }' > " . shellescape(a:fname)
  else
    exe "silent write !pandoc -f " . a:from . " -t " . a:to . " -o " . shellescape(a:fname)
  endif

  setlocal nomod
endfunction
