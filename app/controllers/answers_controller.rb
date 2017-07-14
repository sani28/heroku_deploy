class AnswersController < ApplicationController

  def create
    @question = Question.find params[:question_id]
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
  end

  if @answer.save
    redirect_to question_path(@question)
  else
    @answers = @question.answers.order(created_at :desc)
    render 'questions/show'
  end
end


  def destroy
    if can?(:destroy, answer)
    answer = Answer.find params[:id]
    answer.destroy
    redirect_to question_path(answer.question)
  else
    head :unauthorized
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end

end #
