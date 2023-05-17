# Morphological transducer for Zilo Andi

[![DOI](https://zenodo.org/badge/540707556.svg)](https://zenodo.org/badge/latestdoi/540707556)

This is a repository for a morphological parser for Zilo Andi.

## Background

Andi belongs to the Andic group within the Avar-Andic branch of the Nakh-Daghestanian family. Aglarov (2002: 3) estimates the Andi ethnic population at 40,000, including 17,000 in the historical Andi area situated in the Botlikhsky District of Dagestan and 23,000 outside it, predominantly in the Khasavyurtovsky, Babayurtovsky and Kizilyurtovsky districts of the same republic. A total of 5,800 Andi speakers is recorded in the 2010 Russian census, while the 2002 Russian census recorded 23,729 Andi speakers, which is more consistent with Aglarov’s estimate. Each settlement possesses its own distinct variety of the language. However, following Cercvadze (1965: 312), two broad dialect groups can be recognized: Upper Andi, spoken in the villages of Andi, Ashali, Chanko, Gagatli, Gunkha, Rikvani and Zilo, and Lower Andi, spoken in Muni and Kvankhidatli. This morphological parser is based on the Upper Andi variety of Zilo (endonym ziludirab mic’ːi) described in

```
Kaye, S., Moroz, G., Rochant, N., Verhees, S., and Zakirova, A. (Forthc.). Andi (Zilo dialect). In Lander, Y., Maisak, T., and Koryakov, Y., editors, The Caucasian Languages. An International Handbook. De Gruyter Mouton, Berlin/New York.
```

## Spelling conventions

All analysis/generation are made with Cyrillic script based on Avar that is mostly understandable for the native speakers. However there are several aspects that is differ from Avar script:

- I use Latin capital i instead of [palochka](https://en.wikipedia.org/wiki/Palochka) <Ӏ>, <ӏ>. May be I will change it in the future and make the transducer work with palochka <Ӏ>, Latin capital i and symbol one <1>.
- Unfortunately, native speakers do not distinguish lateral affricate /tɬ/ and long lateral fricative /ɬː/, they prefer to spell both as <лълъ>. However I spell lateral affricate /tɬ/ as <лI>.
- Nasal vowels are spelled with Cyrillic superscript capital n <ᵸ>, for example /ĩʃduɡu/ <иᵸшдугу> 'five'.
- Native speakers usually do not spell glottal stop /ʔ/ <ъ>. For example /reʃuʔa/ <решуъа> 'on the tree' will be probably spelled as <решуа>. However this transducer use glottal stops.

## Usage

In order to use it you need to install [`lexd`](https://github.com/apertium/lexd) and [`hfst`](https://github.com/hfst/hfst):

```
curl -sS https://apertium.projectjj.com/apt/install-nightly.sh | sudo bash
apt install lexd
apt install hfst
```

After it you can clone the repository and compile it:

```
git clone git@github.com:agricolamz/zilo_transducer.git
cd zilo_trasducer
make
```

If everything is fine you can 

- analyze some form

```
$ echo "боъоцIоллой" | hfst-lookup ani_analizer.hfst 
hfst-lookup: warning: It is not possible to perform fast lookups with OpenFST, std arc, tropical semiring format automata.
Using HFST basic transducer format and performing slow lookups
> боъоцIоллой	<an><sg>оъо<num><crown><linker>	0.000000
боъоцIоллой	<inan1>оъо<num><crown><linker>	0.000000
```

- generate some form

```
$ echo "чIе<num><crown><card>" | hfst-lookup ani_generator.hfst 
hfst-lookup: warning: It is not possible to perform fast lookups with OpenFST, std arc, tropical semiring format automata.
Using HFST basic transducer format and performing slow lookups
> чIе<num><crown><card>	чIецIолгу	0.000000
```

- see all possible forms and analyses:

```
$ hfst-fst2strings ani_analizer.hfst
```

## How to cite this parser

If you want to cite this work use the following format:

```
Moroz, G. (2022) Morphological parser for Zilo Andi. (Version 0.0.1)
```

## Number of forms generated: 

50336
