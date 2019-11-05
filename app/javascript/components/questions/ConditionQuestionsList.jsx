var React = require("react");
import SelectedQuestionAnswers from "./SelectedQuestionAnswers";
import axios from "axios";

function MethodList(props) {
  const questionType = props.question_type;

  if (questionType == "Textarea") {
    return render;
  } else {
  }
}

export default class ConditionQuestionsList extends React.Component {
  constructor(props) {
    super();
    this.state = {
      selected: false,
      selectedQuestion: "",
      answers: [],
      questionType: ""
    };
  }

  handleSelectedQuestion = e => {
    let initialAnswer = [];
    const self = this;
    axios
      .get("/api/v1/questions/" + e.target.value)
      .then(function(response) {
        console.log(response.data);
        initialAnswer = response.data.question_answers.map(answer => {
          return answer;
        });
        self.setState({
          answers: initialAnswer,
          questionType: response.data.q_type
        });
      })
      .catch(function(error) {
        console.log(error);
      });
    this.setState({ selectedQuestion: e.target.value, selected: true });
  };

  render() {
    var self = this.state;
    var openEnded = [
      "contains",
      "does not contains",
      "is empty",
      "is not empty",
      "is anything"
    ];
    var multipleChoice = ["is equal to", "is not equal to", "is anything"];
    let questions = this.props.state.questions;
    let optionItems = questions.map(question => (
      <option key={question.id} value={question.id}>
        {question.code}.{question.description}
      </option>
    ));

    let openEndedList = openEnded.map(method => (
      <option key={method} value={method}>
        {method}
      </option>
    ));

    let multipleChoiceList = multipleChoice.map(method => (
      <option key={method} value={method}>
        {method}
      </option>
    ));

    return (
      <div>
        <div className="control">
          <div className="select">
            <select onChange={this.handleSelectedQuestion}>
              {optionItems}
            </select>
          </div>
        </div>

        {self.selected == true ? (
          <div className="pt-10">
            <div className="control">
              <div className="select">
                <select>
                  {self.questionType == "Textarea"
                    ? openEndedList
                    : multipleChoiceList}
                </select>
              </div>
            </div>
            <SelectedQuestionAnswers answers={self.answers} />
          </div>
        ) : (
          ""
        )}
      </div>
    );
  }
}
