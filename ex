function ex --description "Expand or extract bundled & compressed files"
  set --local ext (echo $argv[1] | awk -F. '{print $NF}')
  switch $ext
    case tar  
      tar -xvf $argv[1]
    case gz
      if test (echo $argv[1] | awk -F. '{print $(NF-1)}') = tar 
        tar -zxvf $argv[1]
      else  
        gunzip $argv[1]
      end
    case tgz
      tar -zxvf $argv[1]
    case bz2
      tar -jxvf $argv[1]
    case rar
      unrar x $argv[1]
    case zip
      unzip $argv[1]
    case zst
      zstd -d $argv[1]
    case '*'
      echo "unknown extension"
  end
end
