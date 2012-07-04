
Przy pomocy JEdita lub innego edytora tekstowego poszukaj wyrażeniem regularnym:

([\t\n\r\ ~]+)([uioazw])([\t\n\r\ ]+)

i zamień na:

$1$2~

przy włączonym ignorowaniu wielkości znaków. I tak wielokrotnie, dopóki są
jakieś zmiany (istotne przy sąsiadujących spójnikach, np. "i u siebie").

Oczywiście należy sprawdzić, czy się nic nie posypało.
