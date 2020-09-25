function gw --description 'Find gradlew or use gradle'
  set d (pwd)
  while not test -e "$d/gradlew"; and test "$d" != "/"
    set d (realpath "$d/../")
  end
  set d (test -e "$d/gradlew"; and echo "$d/gradlew"; or which gradle)
  if test -z "$d"; or not test -e $d
    echo 'Error: Gradle not found'
    return 1
  end
  $d $argv
end
