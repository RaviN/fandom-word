fandom-word
====
[![Gem Version](https://badge.fury.io/rb/fandom-word.svg)](https://badge.fury.io/rb/fandom-word)
[![Build Status](https://travis-ci.org/RaviN/fandom-word.svg?branch=master)](https://travis-ci.org/RaviN/fandom-word)

A fandom word generator that returns random words from various fandoms.

How to use
----

fandom-word allows you to get a randomized word pertaining to any fandom.
You can also use it to get a randomized word for a specific fandom.

```ruby
FandomWord.random_word # returns a word from any fandom category
FandomWord.random_word(fandom_name) # returns a word from a specific fandom
FandomWord.random_word([fandom_name_1, fandom_name_2]) # returns a word from one of the fandoms
FandomWord.fandoms # list fandoms
```

Available fandoms are defined as constants in `FandomWord::Fandoms`

Adding Fandoms
----

* Fork the repo
* Add your fandom word list ( keep it clean or your pull request will be rejected )
  * When adding your word list use the following format
  ```yaml
  :categories:
  - list
  - of
  - applicable
  - categories
  :words:
  - list
  - of
  - words
  ```
* Make sure all tests are still passing and there is 100% code coverage
* Submit pull request