# Оптимизация шрифтов

![Before](before.gif)

![After](after.gif)

[Examples](https://yankovsky.github.io/font-optimization/)


## Google Fonts

[Google fonts example](https://yankovsky.github.io/font-optimization/examples/1-google-fonts/index.html)

* очень легко подключить
* мы не контролируем, что отдаёт google fonts (формат, определение по ua, subset'ы)
* есть возможность subset'а, но работает [не очень надёжно](https://github.com/Munter/subfont/issues/109)
* лишние запросы
* неоптимальные файлы
* lazy загрузка шрифтов
* подключение к дополнительному хосту
* задержка при загрузке шрифтов
* есть маленький шанс, что запросы уже будут закешированы
* есть [проблемы с GDPR](https://github.com/google/fonts/issues/1495)



## font-display

[Font display example](https://yankovsky.github.io/font-optimization/examples/2-font-display/index.html)

(MDN)[https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face/font-display]

Обычно используются swap или block.



## Локальное размещение шрифтов

[Local fonts example](https://yankovsky.github.io/font-optimization/examples/3-local-fonts/index.html)

* надо написать css с font-face
* не забываем про кеширование!



## Приоритизация загрузки

[Link preload example](https://yankovsky.github.io/font-optimization/examples/4-link-preload/index.html)

### link preload

[MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Preloading_content)

```html
  <link
    rel="preload"
    as="font"
    type="font/woff2"
    crossOrigin="anonymous"
    href="MyFont.woff2"
  />
```

`as` учитывается при приоритизации запроса

Если `type` не поддерживается браузером, то запрос не будет выполнен

[crossOrigin anonymous](https://developer.mozilla.org/en-US/docs/Web/HTML/Preloading_content#Cross-origin_fetches)
Без него будет выполнено два запроса, один без передачи Origin хедера (no-cors), а второй с его передачей (cors)

[Поддержка](https://caniuse.com/#feat=link-rel-preload)

### FontFace API

[MDN](https://developer.mozilla.org/en-US/docs/Web/API/FontFace)

[Поддержка лучше](https://caniuse.com/#feat=mdn-api_fontface), чем у preload, но это дополнительный js.



## Subset шрифтов

Удаление неиспользуемых символов из файлов шрифтов.

### Инструменты

[glyphhanger](https://github.com/filamentgroup/glyphhanger)

Умеет по url собирать используемые символы по каждому шрифту.

[subfont](https://github.com/Munter/subfont)

Умеет как glyphhanger + умеет заменять при сборке ссылку на google fonts в html файлах 
на простыню html с subset, preload, font api и инлайном css font-face. 

Оба инструмента не очень надёжные, если есть много динамики.

Также, они оба под капотом используют python библиотеку [fonttools](https://github.com/fonttools/fonttools),
требуют её установки и фактически проксируют к ней запросы, добавляя небольшой функционал.

[Fonttools example](https://yankovsky.github.io/font-optimization/examples/5-fonttools/index.html)

## Как не пропустить символ при subset'е?

[Fallback example](https://yankovsky.github.io/font-optimization/examples/6-fallback/index.html)

Не существует браузерного API, которое бы позволяло узнать,
что какие-то символы не были найдены в загруженном шрифте.

Моё предложение, использовать для разработки специальный шрифт,
в котором все символы одинаковые и бросаются в глаза
Создал прототип такого шрифта на основе Roboto в Font Forge



## variable-fonts

* модно молодёжно
* нужно загрузить только один файл
* размер больше, чем размер одного статичного начертания
* можно жать в woff2, можно subset'ить
* не для всех шрифтов есть variable версия, например [Roboto VF](https://github.com/TypeNetwork/Roboto) в активной разработке
* variable шрифты могут быть variable только по определённому параметру (например, вес, но не курсив)
* [поддержка хорошая](https://caniuse.com/#feat=variable-fonts), но хуже чем у статичных шрифтов
* можно проверять поддержку через css правило `@supports (font-variation-settings: normal)`

Примеры в этом репозитории [Comforta VF](fonts/Comfortaa/README.txt)


## Наше решение

[CSSSR school](https://font-optimization.new-school-landing.csssr.cloud/ru)

[React компонент](https://yankovsky.github.io/font-optimization/examples/7-our-react-solution/Fonts.jsx)

Roboto VF ~= 6 Roboto начертаний

subset, swap, preload в самом начале странице
