var React = require("react");
import Trumbowyg from "react-trumbowyg";
import { post } from "../../apiUtils/webApi";

export default class MultipleAnswer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      values: [{ value: null }],
      codes: [],
      status:
        '<span class="tag is-warning" id="status">This code is exists. Please use unique code for each question.</span>',
      error: false,
      attached_to: ""
    };
  }

  handleChange = (i, event) => {
    let values = [...this.state.values];
    values[i].value = event.target.value;
    this.setState({ values });
  };

  handleCodeChanges = (val, index) => {
    var value = this.state.codes.slice();
    value[index] = val;
    this.setState({
      codes: value
    });
  };

  addClick = () => {
    this.setState(prevState => ({
      values: [...prevState.values, { value: null }]
    }));
  };

  removeClick = i => {
    let values = [...this.state.values];
    values.splice(i, 1);
    this.setState({ values });
  };

  handleSubmit = e => {
    var self = this.props;
    e.preventDefault();
    const form = event.target;
    const data = new FormData(form);
    data.set("question[question_group_id]", self.group_id);
    data.set("question[survey_id]", this.props.survey_id);
    data.set("question[q_type]", self.types);
    post("/questions", data)
      .then(response => {
        window.location.href =
          "/users/manage/questions/" +
          response.data.object.id +
          "?group_id=" +
          self.group_id +
          "";
      })
      .catch(errorMessage => {
        this.setState({
          error: true
        });
      });
  };

  render() {
    var self = this.props;
    var answer_limit;
    var warning;
    const islimit = "Checkbox with Limit";

    const questionOptions = self.questions.map((question, i) => (
      <option key={i} value={question.id}>
        {question.code + ". " + question.description}
      </option>
    ));

    if (islimit == self.types) {
      answer_limit = (
        <div className="field">
          <label className="label">Limit Answers</label>
          <input
            type="number"
            className="input"
            name="question[limit]"
            id="answer_limit"
            placeholder
          />
        </div>
      );
    }
    if (this.state.error == true) {
      warning = <div dangerouslySetInnerHTML={{ __html: this.state.status }} />;
    }
    return (
      <form onSubmit={this.handleSubmit}>
        <div className="column is-12 ">
          <h5>{self.types}</h5>
        </div>
        <div className="column is-12">
          <div className="buttons">
            <a
              className="button is-black is-small"
              onClick={() => this.props.handler(0)}
            >
              Back to options
            </a>
            <button type="submit" className={"button is-primary is-small"}>
              Create
            </button>
          </div>
          <div className="content">
            <div className="field">{warning}</div>
            <div className="field">
              <label className="label">Question Code</label>
              <input type="text" className="input" name="question[code]" />
              <small>*Question code are required.</small>
            </div>
            <div className="field">
              <label className="label">Question</label>
              <Trumbowyg
                id="questionDescription"
                name="question[description]"
              />
            </div>
            <div className="field">
              <label className="label">
                Attached to (Optional){" "}
                <span
                  className="has-tooltip-right"
                  data-tooltip="Select parent question for looping purposes (Optional)"
                >
                  <i className="fas fa-question-circle"></i>
                </span>
              </label>
              <div class="select is-fullwidth">
                <select
                  name="question[attached_to]"
                  onChange={e => this.handleChange(i, e)}
                >
                  <option>Select parent question</option>
                  {questionOptions}
                </select>
              </div>
            </div>
            {answer_limit}
            <div className="field">
              <label className="label">This question is mandatory?</label>
              <input
                type="checkbox"
                name="question[mandatory]"
                id="switch"
              ></input>
              <label className="toggle" for="switch"></label>
            </div>
            <div className="field">
              <label className="label">
                Answer Options{" "}
                <a
                  className="button is-primary is-circle is-small"
                  onClick={() => this.addClick()}
                >
                  <i className="fa fa-plus"></i> Add Field
                </a>
              </label>
            </div>
            {this.state.values.map((el, i) => (
              <div key={i} className="columns">
                <div className="column is-1">{i + 1}.</div>
                <div className="column is-3">
                  <input
                    type="text"
                    value={this.state.codes[i]}
                    className="input is-small"
                    name="code[]"
                    placeholder="Code"
                    onChange={this.handleCodeChanges.bind(this, i)}
                  />
                </div>
                <div className="column is-6">
                  <input
                    type="text"
                    value={el.value || ""}
                    className="input is-small"
                    name="answer[]"
                    placeholder="Answer"
                    onChange={e => this.handleChange(i, e)}
                  />
                </div>
                <div className="column is-2">
                  <a
                    className="button is-danger is-small"
                    onClick={() => this.removeClick()}
                  >
                    <i className="fa fa-times"></i>
                  </a>
                </div>
              </div>
            ))}
          </div>
        </div>
      </form>
    );
  }
}
