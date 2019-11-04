var React = require("react");
import axios from "axios";

export default class ConditionQuestionsList extends React.Component {
  constructor(props) {
    super();
  }

  render() {
    let questions = this.props.state.quetions;
    let optionItems = questions.map(question => (
      <option key={question.id}>{question.title}</option>
    ));

    return (
      <div>
        <select>{optionItems}</select>
      </div>
    );
  }
}
