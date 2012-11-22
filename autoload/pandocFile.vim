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

function! pandocFile#DefAuto(pattern, from, to)
  exe 'autocmd BufReadCmd,FileReadCmd ' . a:pattern . ' call pandocFile#Read(expand("<amatch>"), "' . a:from . '", "' . a:to . '")'
  exe 'autocmd BufWriteCmd,FileWriteCmd ' . a:pattern .' call pandocFile#Write(expand("<amatch>"), "' . a:to . '", "' . a:from .'")'
endfunction
