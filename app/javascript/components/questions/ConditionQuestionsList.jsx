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
      selectedMethod: "",
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
    this.props.question_id_handler(this.props.index, e.target.value);
  };

  handleSelectedMethod = e => {
    this.setState({ selectedMethod: e.target.value });
    this.props.method_handler(this.props.index, e.target.value);
  };

  render() {
    var self = this.state;
    var openEnded = [
      "Please select",
      "contains",
      "does not contains",
      "is empty",
      "is not empty"
    ];
    var multipleChoice = [
      ["Please select", ""],
      ["is equal to", "="],
      ["is not equal to", "!="]
    ];
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
      <option key={method} value={method[1]}>
        {method[0]}
      </option>
    ));

    return (
      <div className="pt-10">
        <div className="control">
          <div className="select">
            <select onChange={this.handleSelectedQuestion}>
              <option>Please select</option>
              {optionItems}
            </select>
          </div>
        </div>

        {self.selected == true ? (
          <div className="pt-10">
            <div className="control">
              <div className="select">
                <select onChange={this.handleSelectedMethod}>
                  {self.questionType == "Textarea"
                    ? openEndedList
                    : multipleChoiceList}
                </select>
              </div>
            </div>
            <SelectedQuestionAnswers
              index={this.props.index}
              answers={self.answers}
              question_type={self.questionType}
              selected_method={self.selectedMethod}
              value_handler={this.props.value_handler}
            />
          </div>
        ) : (
          ""
        )}
      </div>
    );
  }
}
