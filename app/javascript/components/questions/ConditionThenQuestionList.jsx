var React = require("react");
import axios from "axios";

export default class ConditionThenQuestionsList extends React.Component {
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
    this.props.handler(e.target.value);
  };

  handleSelectedMethod = e => {
    this.setState({ selectedMethod: e.target.value });
  };

  render() {
    var self = this.state;
    let questions = this.props.state.questions;
    let optionItems = questions.map(question => (
      <option key={question.id} value={question.id}>
        {question.code}.{question.description}
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
      </div>
    );
  }
}
