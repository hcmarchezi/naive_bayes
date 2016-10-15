# NBClass

This gem provides a naive bayes classifier for models with N features.
Simply put given examples of pre-defined categories the classifier learns how
to classify new unknown examples.

## Usage

Classifier can be used in three steps:

1. Provide category names and its respective training set

2. Train classifier with provided categories

3. Classify models

For instance the example below shows how to classify words in categories test_a and test_b.
Taking in consideration the number of occurrences of each word in both categories besides
the frequency of the category the classifier returns the most probable category for the
given collection of features.

```ruby
require 'nb_class/classifier'

# 1 - Providing examples
classifier = NBClass::Classifier.new
classifier.not_spam << "Hi Joe, how are you?"
classifier.spam << "Buy products you don't need"

# 2 - Train classifier
classifier.train

# 3 - Classify new examples
classifier.classify("Hi James, are you going?") # => not_spam
classifier.classify("Buy not needed product") # => spam
```

## Planed Future Features

1. Load category examples from external files to reduce code size
2. Load pre-trained data from file to decrease classifier initialization time
3. Optimize algorithms to use pre-calculated values

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
