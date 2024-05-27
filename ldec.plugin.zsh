#!/usr/bin/env zsh

typeset -A en_ru_map
typeset -A ru_en_map

en_alphabet=("F" "<" "D" "U" "L" "T" "~" ":" "P" "B" "Q" "R" "K" "V" "Y" "J" "G" "H" "C" "N" "E" "A" "{" "W" "X" "I" "O" "}" "S" "M" "\"" ">" "Z" "f" "," "d" "u" "l" "t" "\`" ";" "p" "b" "q" "r" "k" "v" "y" "j" "g" "h" "c" "n" "e" "a" "[" "w" "x" "i" "o" "]" "s" "m" "'" "." "z" "/" "?" "-" "^" "$" "!" "@" "#" "%" "&" "*" "(" ")" "=" "+" "_" "|" "\\")

ru_alphabet=("А" "Б" "В" "Г" "Д" "Е" "Ё" "Ж" "З" "И" "Й" "К" "Л" "М" "Н" "О" "П" "Р" "С" "Т" "У" "Ф" "Х" "Ц" "Ч" "Ш" "Щ" "Ъ" "Ы" "Ь" "Э" "Ю" "Я" "а" "б" "в" "г" "д" "е" "ё" "ж" "з" "и" "й" "к" "л" "м" "н" "о" "п" "р" "с" "т" "у" "ф" "х" "ц" "ч" "ш" "щ" "ъ" "ы" "ь" "э" "ю" "я" "." "," "-" ":" ";" "!" "\"" "№" "%" "?" "*" "(" ")" "=" "+" "_" "/" "\\")

for i in {1..84}; do
    en_ru_map[$en_alphabet[$i]]=$ru_alphabet[$i]
    ru_en_map[$ru_alphabet[$i]]=$en_alphabet[$i]
done

decode() {
    local input=$1
    local output=""
    local found=0

    for (( i=1; i<=${#input}; i++ )); do
        char=${input[$i]}
        if [[ -n ${en_ru_map[$char]} ]]; then
            output+=$en_ru_map[$char]
            found=1
        elif [[ -n ${ru_en_map[$char]} ]]; then
            output+=$ru_en_map[$char]
            found=1
        else
            output+=$char
        fi
    done

    echo $output
    return $found
}

correct_command() {
    local command=$1
    local decoded_command=$(decode "$command")

    if command -v "$decoded_command" &> /dev/null; then 
        read -q "response?zsh: correct '$command' to '$decoded_command' [y/n]? "
        
        if [[ $response == 'y' ]]; then
            echo  
            eval "$decoded_command"
            return 0  
        else
            echo -e "\033[1A\033[2K\033[1G\c"
            echo "zsh: correct '$command' to '$decoded_command' [y/n]? n"
            echo "zsh: command not found: $command"
            return 1 
        fi 
    fi
}

command_not_found_handler() {
    correct_command "$1"
}
