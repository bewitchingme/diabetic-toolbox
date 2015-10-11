module DiabeticToolbox
  class CreateMemberReading < Exchange
    #region Init
    def initialize(member, reading_params)
      super reading_params
      @member = member
    end
    #endregion

    #region Hooks
    hook :default do
      @reading = @member.readings.new call_params

      if @reading.save
        success do |option|
          option.subject = @reading
          option.message = I18n.t('flash.reading.created.success')
        end
      else
        failure do |option|
          option.subject = @reading
          option.message = I18n.t('flash.reading.created.failure')
        end
      end
    end
    #endregion
  end
end
