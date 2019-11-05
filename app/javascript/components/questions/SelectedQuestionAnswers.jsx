var React = require("react");

export default class SelectedQuestionAnswers extends React.Component {
  constructor(props) {
    super();
  }

  render() {
    let answers = this.props.answers;
    let optionItems = answers.map(answer => (
      <option key={answer.id} value={answer.value}>
        {answer.code}. {answer.exact_value}
      </option>
    ));

    return (
      <div className="pt-10">
        <div className="control pt-10">
          <div className="select">
            <select>{optionItems}</select>
          </div>
        </div>
      </div>
    );
  }
}
