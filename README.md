# Morphological transducer for Zilo Andi

[![DOI](https://zenodo.org/badge/540707556.svg)](https://zenodo.org/badge/latestdoi/540707556)

This is a repository for a morphological parser for Zilo Andi.

## How to cite this parser

If you want to cite this work use the following format:

```
Moroz, G. (2026) Morphological parser for Zilo Andi. (Version 0.0.2) https://doi.org/10.5281/zenodo.7123352
```

## Background

Andi belongs to the Andic group within the Avar-Andic branch of the Nakh-Daghestanian family. Aglarov (2002: 3) estimates the Andi ethnic population at 40,000, including 17,000 in the historical Andi area situated in the Botlikhsky District of Dagestan and 23,000 outside it, predominantly in the Khasavyurtovsky, Babayurtovsky and Kizilyurtovsky districts of the same republic. A total of 5,800 Andi speakers is recorded in the 2010 Russian census, while the 2002 Russian census recorded 23,729 Andi speakers, which is more consistent with Aglarov's estimate. Each settlement possesses its own distinct variety of the language. However, following Cercvadze (1965: 312), two broad dialect groups can be recognized: Upper Andi, spoken in the villages of Andi, Ashali, Chanko, Gagatli, Gunkha, Rikvani and Zilo, and Lower Andi, spoken in Muni and Kvankhidatli. This morphological parser describes the Upper Andi variety of Zilo (endonym [ziludirab mic'ːi]). The bases of the morphological parser are the field trip data by the author and some published resources:

- Kaye, S., Moroz, G., Rochant, N., Verhees, S., and Zakirova, A. (Forthc.). Andi (Zilo dialect). In Lander, Y., Maisak, T., and Koryakov, Y., editors, The Caucasian Languages. An International Handbook. De Gruyter Mouton, Berlin/New York.
- Verhees, S. (2019) Demonstratives in Zilo Andi, handout.
- Ферхеес, С. (2017) Глагол в зиловском диалекте андийского языка: парадигма, хэндаут.
- Moroz G. (2017) Zilo numerals, handout.

Lexical basis for the transducer is Online Dictionary of Zilo Andi:

- Moroz, G. (2026). Online Dictionary of Zilo Andi (v1.0.3). Moscow. DOI: 10.5281/zenodo.13952695. https://lingconlab.github.io/zilo_dictionary/.

## Spelling conventions

All analysis/generation are made with Cyrillic script based on Avar that is mostly understandable for the native speakers. However there are several aspects that is differ from Avar script:

- I use Latin capital i instead of [palochka](https://en.wikipedia.org/wiki/Palochka) <Ӏ>, <ӏ>. May be I will change it in the future and make the transducer work with palochka <Ӏ>, Latin capital i and symbol one <1>.
- Unfortunately, native speakers do not distinguish lateral affricate /tɬ/ and long lateral fricative /ɬː/, they prefer to spell both as <лълъ>. However I spell lateral affricate /tɬ/ as <лI>.
- Nasal vowels are spelled with Cyrillic superscript capital n <ᵸ>, for example /ĩʃduɡu/ <иᵸшдугу> 'five'.
- Native speakers usually do not spell glottal stop /ʔ/ <ъ>. For example /reʃuʔa/ <решуъа> 'on the tree' will be probably spelled as <решуа>. However this transducer use glottal stops.

## Usage

The following commands will work on some versions of Linux and in Google Colab (just change the dollar sign and the following spase before each command with the exclamation mark).

In order to use the parser you need to install [`lexd`](https://github.com/apertium/lexd) and [`hfst`](https://github.com/hfst/hfst):

```
$ curl -sS https://apertium.projectjj.com/apt/install-nightly.sh | sudo bash
$ apt install lexd hfst
```

After you can clone the repository and compile it:

```
$ git clone git@github.com:agricolamz/zilo_transducer.git
$ cd zilo_trasducer
$ make
```

If everything is fine you can

- analyze some form

```
$ echo "дибо" | hfst-lookup ani_analyzer.hfstol

> дибо  ден<PRON>><aff><an.sg>  0,000000
дибо    ден<PRON>><aff><inan1>  0,000000
```

- analyze some form and translate the stem into Russian

```
$ echo "дибо" | hfst-lookup ani_analyzer_stem_translation.hfstol

> дибо  я<PRON>><aff><an.sg>    0,000000
дибо    я<PRON>><aff><inan1>    0,000000
```

- generate some form

```
$ echo "мен<PRON>><dat>" | hfst-lookup ani_generator.hfstol

> мен<PRON>><dat>   ду>й    0,000000
мен<PRON>><dat> ду>лъу  0,000000
```

- generate the paradigm:

```
$ make substring_search REGEX="м е н %<PRON%> ?*"

hfst-compose-intersect: Warning: 
Found output symbols (e.g. "@_IDENTITY_SYMBOL_@") in transducer in
file <stdin> which will be filtered out because they are
not found on the input tapes of transducers in file
ani_generator.hfst.

мен<PRON>><dat>:ду>лъу
мен<PRON>><dat>:ду>й
мен<PRON>><gen><an><sg>:ду>б
мен<PRON>><gen><inan1>:ду>б
мен<PRON>><gen><inan1>><pl>:ду>б>ул
мен<PRON>><gen>:ду>лIи
мен<PRON>><gen><f>:ду>й
мен<PRON>><gen><f>><pl>:ду>й>ил
мен<PRON>><gen><an><pl>:ду>й
мен<PRON>><gen><an><pl>><pl>:ду>й>ил
мен<PRON>><gen><m>:ду>в
мен<PRON>><gen><m>><pl>:ду>в>ул
мен<PRON>><gen><inan2>:ду>р
мен<PRON>><gen><inan2>><pl>:ду>р>ул
мен<PRON>><aff><an><sg>:ду>бо
мен<PRON>><aff><inan1>:ду>бо
мен<PRON>><aff><f>:ду>йо
мен<PRON>><aff><an><pl>:ду>йо
мен<PRON>><aff><m>:ду>во
мен<PRON>><aff><inan2>:ду>ро
мен<PRON>><sub>><el>:ду>кьи>кку
мен<PRON>><sub><ess>:ду>кьи
мен<PRON>><sub><lat>:ду>кьи
мен<PRON>><super>><el>:ду>ъа>кку
мен<PRON>><super><ess>:ду>ъа
мен<PRON>><super><lat>:ду>ъо
мен<PRON>><in><lat>:ду>ди
мен<PRON>><in>><el>:ду>ла>кку
мен<PRON>><in><ess>:ду>ла
мен<PRON>><inter>><el>:ду>лIи>кку
мен<PRON>><inter><ess>:ду>лIи
мен<PRON>><inter><lat>:ду>лIи
мен<PRON>><ad>><el>:ду>хо>кку
мен<PRON>><ad><ess>:ду>ха
мен<PRON>><ad><lat>:ду>хо
мен<PRON>><apud>><el>:ду>хъи>кку
мен<PRON>><apud><ess>:ду>хъи
мен<PRON>><apud><lat>:ду>хъи
мен<PRON>><cont>><el>:ду>чIу>кку
мен<PRON>><cont><ess>:ду>чIу
мен<PRON>><cont><lat>:ду>чIу
мен<PRON>:мен
мен<PRON>><erg>:мен>ни
```

- generate the subparadigm:

```
$ make substring_search REGEX="г ь о б %<PRON%> ?* %<erg%> ?*"

hfst-compose-intersect: Warning: 
Found output symbols (e.g. "@_IDENTITY_SYMBOL_@") in transducer in
file <stdin> which will be filtered out because they are
not found on the input tapes of transducers in file
ani_generator.hfst.
гьоб<PRON>><obl><m><pl>><erg>:гьо>лу>ди
гьоб<PRON>><obl><nm>><erg>:гьо>л>ди
гьоб<PRON>><obl><nm><pl>><erg>:гьо>ли>ди
гьоб<PRON>><obl><m>><erg>:гьо>ш>ди
```

- calculate number of the distinct forms in the paradigm:

```
$ make substring_search REGEX="г ь о б о б %<PRON%> ?*" | wc -l

hfst-compose-intersect: Warning: 
Found output symbols (e.g. "@_IDENTITY_SYMBOL_@") in transducer in
file <stdin> which will be filtered out because they are
not found on the input tapes of transducers in file
ani_generator.hfst.

882
```

- analyze phrase. There are several output formats that defined by flags `-x`, `-C`. It is possible to change `ani_analyzer_stem_translation.hfstol` into `ani_analyzer.hfstol` in order to get the initial stem instead of the translation.

```
$ echo "дибо мен гьаъо" | hfst-proc ani_analyzer_stem_translation.hfstol

^дийо/я<PRON>\><aff><an.pl>/я<PRON>\><aff><f>$ ^мен/ты<PRON>$ ^гьаъо/*гьаъо$
```

```
$ echo "дибо мен гьаъо" | hfst-proc -x ani_analyzer_stem_translation.hfstol
дийо	я<PRON>><aff><an.pl>
дийо	я<PRON>><aff><f>

мен	ты<PRON>

гьаъо	+?
```

```
$ echo "дибо мен гьаъо" | hfst-proc -C ani_analyzer_stem_translation.hfstol
"<дийо>"
	"я"	PRON > aff an.pl
	"я"	PRON > aff f
"<мен>"
	"ты"	PRON
"<гьаъо>"
	"*гьаъо"
```

As you see, there are some unusual for the most theoretical linguists hfst convetions:

- morphological analysis by default returns lemma instead of a translation;
- glosses are listed in angle brackets `<...>`;
- morpheme boundary is marked with the angle bracket `>`;
- word lemma is followed by POS-tag in capitals.

## POS coverage of the transducer

At the moment morphological transducer covers:

- Personal pronouns
- Demonstratives

