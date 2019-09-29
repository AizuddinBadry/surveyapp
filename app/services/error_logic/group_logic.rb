class ErrorLogic::GroupLogic
    include Callable
    
    def initialize(id)
      @id = id
      @errors = 0
    end
    
    def call
      @group = QuestionGroup.find_by_id(@id)
      @group.update verify_error: true
      @group.group_error_logics.delete_all
      check_question
      check_question_answer
      if @errors == 0
        @group.update any_error: false
        return true
      else
        @group.update any_error: true
        return false
      end
    end

    private

    def check_question
      if @group.questions.size < 1
          @errors += 1
          @group.group_error_logics.build text: "Group doesn't have any questions available."
          @group.save
      end
    end

    def check_question_answer
      @group.questions.each do |question|
        if question.q_type != 'Textarea'
          if question.question_answers.size < 1
            @errors += 1
            @group.group_error_logics.build text: "Question code #{question.code} don't have an answers available."
            @group.save
          end
        end
      end
    end
end