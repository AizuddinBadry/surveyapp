
module Questions
    class Submission
        @message = ''
        @question = ''
        @question_position = ''
        @check_condition = false
        @previous_position = 0

        def self.submit(args = {})
            @message = ''
            @current_question_pos = args[:q1]
            @next_question_pos = args[:q2]
            @answer = args[:answer]
            @survey_id = args[:survey_id]
            
            @next_question = Questions::Submission.query_question(@next_question_pos, @survey_id) #Query next question for return data
            @current_question = Questions::Submission.query_question(@current_question_pos, @survey_id) #Query current question to check validation, logic, etc
            
            @question = @next_question
            @question_position = @next_question_pos
            if @current_question.mandatory == true
                @message = 'Please fill in the answer.' unless args[:answer].present?
                @question =  @current_question unless args[:answer].present?
                @question_position = @current_question_pos unless args[:answer].present?
            else
                @message = ''
                @question_position = @next_question_pos
            end unless @current_question.nil?

            Questions::SaveAnswer.new(@survey_id, @current_question.id, @answer, args[:survey_session], args[:time_per_question]) unless @current_question.nil?
            if args[:answer].present?
                if @current_question.conditions.present?
                    @previous_position = @current_question_pos
                    @condition_pos = Questions::Submission.condition_check(@current_question.id, args[:session], @answer, @survey_id)
                    @question = Questions::Submission.query_question(@condition_pos, @survey_id) unless @condition_pos == false || @condition_pos == 'end'
                    Rails.logger.info ">>>>>>>>CONDITION CHECK #{@condition_pos}"
                    if @condition_pos == 'end'
                        Rails.logger.info ">>>>>>>>CONDITION TO END SURVEY"
                        @question = Questions::Submission.query_question(0, @survey_id)
                    elsif @condition_pos == false
                        Rails.logger.info ">>>>>>>>CONDITION TO NEXT"
                    end
                end
            end
            
            return @question
        end

        private

        def self.query_question(position, survey_id)
            return Question.where(survey_id: survey_id, survey_position: position).first
        end

        def self.message
            return @message
        end

        def self.check_condition
            return @check_condition
        end

        def self.previous_position
            return @previous_position
        end

        def self.result_position
            return @question_position
        end

        def self.condition_check_new(question_id, answer, survey_id)
            @response = ''
            @question = Question.find_by_id(question_id)
            @condition_status = false
            @condition = Condition.where(question_id: question_id)
            if !@condition.nil?
                @condition_size = @condition.size
                @condition_meet = 0
                @next_question_id = 0
                @condition.each do |c|
                    if c.condition_link.present?
                        if c.method == 'is equal to'
                            if c.condition_link.relation == 'and'
                                if answer.include? c.value && answer.include?(c.condition_link.other_condition.value) == true
                                    @condition_meet += 1
                                    @condition_meet == @condition.size ? @next_question_id = c.condition_question_id : 0
                                end
                            elsif c.condition_link.relation == 'or'
                                if answer.include? c.value || answer.include?(c.condition_link.other_condition.value) == true || answer == c.value
                                    @condition_meet += 1
                                    @condition_meet == @condition.size ? @next_question_id = c.condition_question_id : 0
                                end
                            end
                        elsif c.method == 'is not equal to'
                            if c.condition_link.relation == 'and'
                                if answer.exclude? c.value == true && answer.exclude?(c.condition_link.other_condition.value) == true
                                    @condition_meet += 1
                                    @condition_meet == @condition.size ? @next_question_id = c.condition_question_id : 0
                                end
                            elsif c.condition_link.relation == 'or'
                                if answer.exclude? c.value == true || answer.exclude?(c.condition_link.other_condition.value) == true || answer != c.value
                                    @condition_meet += 1
                                    @condition_meet == @condition.size ? @next_question_id = c.condition_question_id : 0
                                end
                            end
                        end
                    else    
                        if c.method == 'is equal to'
                            if answer.include? c.value || answer == c.value
                                Rails.logger.info ">>>>>>TEST20"
                                @condition_meet += 1
                                @condition_meet == @condition.size ? @next_question_id = c.condition_question_id : 0
                            else
                                @question = Question.where(survey_id: survey_id, survey_position: @question.survey_position.to_i + 1).first
                                @next_question_id = @question.id
                            end
                        elsif c.method == 'is not equal to'
                            if answer.exclude? c.value || answer != c.value
                                @condition_meet += 1
                                @condition_meet == @condition.size ? @next_question_id = c.condition_question_id : 0
                                @question = Question.where(survey_id: survey_id, survey_position: @question.survey_position.to_i + 1).first
                                @next_question_id = @question.id
                            end
                        end
                    end
                end
            end

            if @condition.size == @condition_meet
                @next_question = Question.find_by_id(@condition.last.condition_question_id)
            else
                
            end

            if @next_question_id == 0
                @condition_status = 'end'
            end

            @question = Question.where(survey_id: survey_id, survey_position: @next_question.survey_position).first unless @next_question.nil?
            if @condition_status == 'end'
                @response = 'end'
            else
                @response = @question.survey_position
            end

            return @response
        end

        def self.condition_check(question_id, session, answer, survey_id)
            @response = ''
            @question = Question.find_by_id(question_id)
            @conditions = []
            @tables = ["conditions", 'survey_answers']
            if @question.conditions.size > 0
                if answer.is_a? String
                    @question.conditions.each do |c|
                        @conditions << "conditions.value #{c.method} '#{answer}' #{c.relation}"
                    end
                else
                    @question.conditions.each_with_index do |c, index|
                        if c.relation == 'or'
                            @conditions << "conditions.value #{c.method} '#{answer[index]}' #{c.relation}"
                        elsif c.relation == 'and'
                            @conditions << "conditions.value::bigint IN (#{answer.join(', ')}) and"
                        else
                            @conditions << "conditions.value::bigint NOT IN (#{answer.join(', ')})"
                        end
                    end
                end
                @query = Question.joins(*@tables.map(&:to_sym)).where(id: question_id, survey_answers: {session: session}).where(@conditions.join(" ")).first
                if @query
                    @condition = Condition.where(question_id: question_id).first
                    @question_pos = Question.where(id: @condition.condition_question_id).first
                    @response = @question_pos.survey_position
                    @check_condition = true
                    return @response
                else
                    return @question.survey_position + 1
                end
            else
                return @question.survey_position + 1
            end
        end
    end
end