# NaiveBayes

This gem provides a naive bayes classifier for models with N features.

## Usage

Classifier can be used in three steps:


1) Provide category names and its respective training set 

2) Train classifier with provided categories

3) Classify models 


For instance the example below shows how to classify words in categories test_a and test_b.
Taking in consideration the number of occurrences of each word in both categories besides 
the frequency of the category the classifier returns the most probable category for the 
given collection of features.


require 'naive_bayes/classifier'

classifier = NaiveBayes::Classifier.new

classifier.add_category(name: :positive_news, training_set: [ 'green', 'green', 'green', 'green', 'blue' ])

classifier.add_category(name: :test_b, training_set: [ 'blue',  'blue',  'blue',  'blue',  'green' ])

classifier.train


classifier.classify(['green','blue','blue','blue') # => test_b

classifier.classify(['green', 'blue', 'green') # => test_a


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
