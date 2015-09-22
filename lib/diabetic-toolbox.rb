
#region Requirements
require 'warden'
require 'kaminari'
require 'diabetic_toolbox/engine'
require 'sessions/session'
require 'diabetic_toolbox/intake_nutrition'
require 'diabetic_toolbox/reference_standard'
require 'paperclip'
require 'haml'
require 'haml-rails'
require 'bootstrap-sass'
require 'cancancan'
require 'bcrypt'
require 'responders'
require 'font-awesome-sass'
require 'friendly_id'
require 'babosa'
require 'chartkick'
require 'momentjs-rails'
require 'bootstrap3-datetimepicker-rails'
require 'prawn-rails'
require 'jquery-rails'
#endregion

#region DiabeticToolbox
module DiabeticToolbox
  #region Module Fields
  @@me   = :diabetic_toolbox
  @@safe = {
      member: [:first_name, :last_name, :username, :slug],
      reading: [],
      recipe: [:name, :servings],
      ingredient: [:name, :volume, :unit],
      step: [:description, :order],
      nutritional_fact: [:nutrient, :quantity, :verified]
  }
  #endregion

  #region Data Response Safeties
  def self.safe(model)
    @@safe[model]
  end
  #endregion

  #region Granularity for Requirements
  def self.from(scope, options = {})
    if options.has_key? :require
      options[:require].each do |requirement|
        require Engine.root.join 'app', 'actions', @@me.to_s, scope.to_s, requirement
      end
    end
  end

  def self.rely_on(*args)
    if args.length > 0
      args.each do |requirement|
        require Engine.root.join 'app', 'actions', @@me.to_s, requirement.to_s
      end
    end
  end
  #endregion

  #region Calculations
  # http://www.wikihow.com/Convert-Grams-to-Calories
  def self.grams_to_calories(intake_nutrition)
    (intake_nutrition.for(:protein) * 4) + (intake_nutrition.for(:carbohydrate) * 4) + (intake_nutrition.for(:fat) * 9)
  end
  #endregion
end
#endregion
