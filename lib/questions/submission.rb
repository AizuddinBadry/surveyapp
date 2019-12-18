
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
                    if @condition_pos == 'end'
                        @question = Questions::Submission.query_question(0, @survey_id)
                    elsif @condition_pos == false
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

        def self.condition_check_new(question_id, session, answer, survey_id)
            @array = []
            @meet_condition = []
            @conditions = Condition.where(question_id: question_id)
            @answer = SurveyAnswer.where(question_id: question_id, session: session).first
            @conditions.order(row: :asc).group_by(&:condition_hash).each do |condition|
                @c_arr = []
                Condition.where(condition_hash: condition.first).each do |c|
                    if answer.is_a? String
                        if c.method == '='
                            @sql = @answer.value == c.value
                        else
                            @sql = @answer.value != c.value
                        end
                    else
                        @answer_arr = JSON.parse @answer.value
                        @answer_arr.each do |a|
                            if c.method == '='
                                @sql = answer.include?(c.value)
                            else
                                @sql = answer.exclude?(c.value)
                            end
                        end
                    end

                    if @sql.present?
                    @c_arr << true
                    else
                    @c_arr << false
                    end
                end
                @array << @c_arr
            end

            # Loop again to compare between conditions
            @conditions.order(row: :asc).group_by(&:condition_hash).each_with_index do |condition, index|
                Condition.where(condition_hash: condition.first).each_with_index do |c, i|
                    if c.relation == 'and'
                        if @array[index][i] && @array[index][i + 1]
                            @meet_condition << true
                        else
                            @meet_condition << false
                        end
                    elsif c.relation == 'or'
                        if @array[index][i] || @array[index][i + 1]
                            @meet_condition << true 
                        else
                            @meet_condition << false
                        end
                    else
                        if @array[0] == true
                            @meet_condition << true
                        end
                    end
                end
            end

            Rails.logger.info ">>>>>>>>>>>>>>>#{@meet_condition}"
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