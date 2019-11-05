var React = require("react");

export default class SelectedQuestionAnswers extends React.Component {
  constructor(props) {
    super();
  }

  handleChanges = e => {
    this.props.value_handler(e.target.value);
  };
  render() {
    const question_type = this.props.question_type;
    const answers = this.props.answers;
    const selected_method = this.props.selected_method;
    let optionItems = answers.map(answer => (
      <option key={answer.id} value={answer.value}>
        {answer.code}. {answer.exact_value}
      </option>
    ));

    if (
      selected_method == "is anything" ||
      selected_method == "is empty" ||
      selected_method == "is not empty"
    ) {
      return "";
    } else {
      return (
        <div className="pt-10">
          <Select
            option_items={optionItems}
            question_type={question_type}
            handler={this.handleChanges}
          />
        </div>
      );
    }
  }
}
function Select(props) {
  if (props.question_type == "Textarea") {
    return (
      <div className="form-group">
        <input type="text" className="input" onChange={props.handler} />
      </div>
    );
  } else {
    return (
      <div className="control pt-10">
        <div className="select" onChange={props.handler}>
          <select>
            <option>Please select</option>
            {props.option_items}
          </select>
        </div>
      </div>
    );
  }
}
