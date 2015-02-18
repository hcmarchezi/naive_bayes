require 'spec_helper'
require 'naive_bayes/classifier'

describe NaiveBayes::Classifier do
  context 'categories' do
    it 'should be added with simbolized name' do
      classifier = NaiveBayes::Classifier.new
      classifier.add_category(name: :bad_news, training_set: [])
      expect(classifier.categories.size).to be_eql(1)
      expect(classifier.categories[0]).to be_eql(:bad_news)
    end

    it 'should not be repeated' do
      classifier = NaiveBayes::Classifier.new
      classifier.add_category(name: :bad_news, training_set: [])
      expect { classifier.add_category(name: :bad_news, training_set: []) }
        .to raise_error(NaiveBayes::Error::CategoryNameAlreadyExists)
    end

    it 'should not be nil' do
      classifier = NaiveBayes::Classifier.new
      expect { classifier.add_category(name: nil, training_set: []) }
        .to raise_error(NaiveBayes::Error::InvalidCategoryName)
    end
  end

  context 'element occurrence count' do
    it 'should count elements occurrence in a category' do
      classifier = NaiveBayes::Classifier.new
      classifier.add_category(name: :test, training_set: ['car', 'tree', 'street', 'truck', 'car'])
      classifier.train
      expect(classifier.element_occurrence(category: :test, element: 'car')).to be_eql(2)
      expect(classifier.element_occurrence(category: :test, element: 'tree')).to be_eql(1)
      expect(classifier.element_occurrence(category: :test, element: 'street')).to be_eql(1)
      expect(classifier.element_occurrence(category: :test, element: 'truck')).to be_eql(1)
    end

    it 'should globally count elements occurrence' do
      classifier = NaiveBayes::Classifier.new
      classifier.add_category(name: :test_a, training_set: ['blue', 'green', 'blue'])
      classifier.add_category(name: :test_b, training_set: ['black', 'black', 'black', 'blue'])
      classifier.train
      expect(classifier.element_occurrence(element: 'blue')).to be_eql(3)
      expect(classifier.element_occurrence(element: 'green')).to be_eql(1)
      expect(classifier.element_occurrence(element: 'black')).to be_eql(3)
    end
  end

  context 'probability calculation' do
    let(:classifier) { NaiveBayes::Classifier.new }
    before do
      classifier.add_category(name: :test_a, training_set: ['blue', 'green', 'blue'])
      classifier.add_category(name: :test_b, training_set: ['black', 'black', 'black', 'blue'])
      classifier.train
    end

    it 'should calculate the probability of an element occurrence given the category' do
      expect(classifier.element_probability_given_category(category: :test_a, element: 'blue')).to be_eql(2.0 / 3.0)
      expect(classifier.element_probability_given_category(category: :test_a, element: 'black')).to be_eql(0.000001)
      expect(classifier.element_probability_given_category(category: :test_a, element: 'green')).to be_eql(1.0 / 3.0)
      expect(classifier.element_probability_given_category(category: :test_a, element: 'gray')).to be_eql(0.000001)
    end

    it 'should calculate the probability of an element occurrence (global context)' do
      expect(classifier.element_probability('blue')).to be_eql(3.0 / 7.0)
      expect(classifier.element_probability('black')).to be_eql(3.0 / 7.0)
      expect(classifier.element_probability('green')).to be_eql(1.0 / 7.0)
      expect(classifier.element_probability('gray')).to be_eql(0.000001)
    end

    it 'should calculate the probability of the category' do
      expect(classifier.category_probability(:test_a)).to be_eql(3.0 / 7.0)
      expect(classifier.category_probability(:test_b)).to be_eql(4.0 / 7.0)
    end
  end

  #####################################
  # P(blue) = 5/10 = 0.5
  # P(green) = 5/10 = 0.5
  #####################################
  # P(blue|A) = 1/5 = 0.2
  # P(green|A) = 4/5 = 0.8
  #####################################
  # P(green|B) = 1/5 = 0.2
  # P(green|A) = 4/5 = 0.8
  #####################################
  # P(A|blue) = 0.5 * ( 0.2/0.5 ) = 0.5 * 0.4 = 0.2
  # P(A|blue,blue,green) = 0.5 * ( 0.2/0.5 * 0.2/0.5 * 0.8/0.5 ) = 0.128
  # P(A|blue,green,green) = 0.5 * ( 0.8/0.5 * 0.8/0.5 * 0.2/0.5 ) = 0.512
  # P(A|green,green,green) = 0.5 * ( 0.8/0.5 * 0.8/0.5 * 0.8/0.5 ) = 2.048
  #####################################
  context 'classification' do
    let(:classifier) { NaiveBayes::Classifier.new }

    before do
      classifier.add_category(name: :test_a, training_set: ['green', 'green', 'green', 'green', 'blue'])
      classifier.add_category(name: :test_b, training_set: ['blue',  'blue',  'blue',  'blue',  'green'])
      classifier.train
    end

    it 'should calculate the probability of an element array to belong to a category' do
      expect(classifier.category_probability_given_elements(category: :test_a, elements: ['blue'])).to eq(0.2)
      expect(classifier.category_probability_given_elements(category: :test_a, elements: ['blue', 'blue',  'green'])).to eq(0.12800000000000003)
      expect(classifier.category_probability_given_elements(category: :test_a, elements: ['blue', 'green', 'green'])).to eq(0.5120000000000001)
      expect(classifier.category_probability_given_elements(category: :test_a, elements: ['green', 'green',  'green'])).to eq(2.0480000000000005)
    end

    it 'should return the most probable category for an element array' do
      expect(classifier.classify(['blue'])).to eq(:test_b)
      expect(classifier.classify(['blue', 'blue',  'green'])).to eq(:test_b)
      expect(classifier.classify(['blue', 'green', 'green'])).to eq(:test_a)
      expect(classifier.classify(['green', 'green',  'green'])).to eq(:test_a)
    end
  end
end
