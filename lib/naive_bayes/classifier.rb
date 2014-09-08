require 'naive_bayes/error/category_name_already_exists'
require 'naive_bayes/error/invalid_category_name'

module NaiveBayes
    class Classifier
        SMALL_PROBABILITY = 0.000001

        def initialize
            @training_sets = { }          
            @occurrences = { }
            @global_occurrences = { }
            @probabilities = { }
            @global_probabilities = { }
            @category_occurrences = { }
            @total_elements = 0
        end

        def add_category(params)
            name = params[:name]
            training_set = params[:training_set]
            validate_category(name)
            @training_sets[name] = training_set
        end

        def categories
            @training_sets.keys
        end

        def train
            @training_sets.keys.each do |category|
                @training_sets[category].each do |element|
                    count_element_occurrence_in_category(category,element)
                    count_element_occurrence_in_global(element)
                    count_category_occurrence(category)
                    @total_elements += 1
                end
            end
        end

        def occurrence(params)
            category = params[:category]
            element = params[:element]
            if category
                @occurrences[category][element]
            else
                @global_occurrences[element]
            end
        end

        def probability_given_category(params)            
            category = params[:category]
            element  = params[:element]
            element_occurrence_in_category = @occurrences[category][element]            
            total_elements_in_category = @occurrences[category].map{ |item| item[1] }.inject{ |sum,item| sum + item }
            if !element_occurrence_in_category.nil?
                element_occurrence_in_category.to_f / total_elements_in_category.to_f
            else
                SMALL_PROBABILITY
            end
        end

        def element_probability(element)
            element_occurrence = @global_occurrences[element]
            if !element_occurrence.nil?
                element_occurrence.to_f / @total_elements
            else
                SMALL_PROBABILITY
            end
        end

        def category_probability(category)
            @category_occurrences[category].to_f / @total_elements.to_f
        end

        # probability = P(category) * Prod i=1 to n( P(element i|category) / P(element i) )
        # review the formula above
        # maybe you can inverse division above 
        #
        #
        def classification_probability(params)
            category = params[:category]
            elements = params[:elements]
            probability = 1.0
            elements.each do |element| 
                element_probability_given_category = probability_given_category(category: category,element: element)
                element_global_probability = element_probability(element)
                element_probability = element_probability_given_category / element_global_probability
                probability *= element_probability
            end
            category_probability = category_probability(category)
            probability *= category_probability
            probability
        end

        private
        def validate_category(name)
            raise NaiveBayes::Error::InvalidCategoryName if name.nil?
            raise NaiveBayes::Error::CategoryNameAlreadyExists if @training_sets.keys.include?(name)        
        end

        def count_element_occurrence_in_category(category,element)
            if !@occurrences.has_key?(category)
                @occurrences[category] = { }
            end
            if !@occurrences[category].has_key?(element)
                @occurrences[category][element] = 1
            else
                @occurrences[category][element] += 1
            end
        end

        def count_element_occurrence_in_global(element)
            if !@global_occurrences.has_key?(element)
                @global_occurrences[element] = 1
            else
                @global_occurrences[element] += 1
            end
        end

        def count_category_occurrence(category)
            if @category_occurrences[category].nil?
                @category_occurrences[category] = 1
            else
                @category_occurrences[category] += 1
            end
        end
    end
end