fandom-word
====

A fandom word generator that returns random words from various fandoms.

How to use
----

fandom-word allows you to get a randomized word pertaining to any fandom.
You can also use it to get a randomized word for a specific fandom.

```ruby
FandomWord.random_word # returns a word from any fandom category
FandomWord.random_word_from_fandom(fandom_name) # returns a word from a specific fandom
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