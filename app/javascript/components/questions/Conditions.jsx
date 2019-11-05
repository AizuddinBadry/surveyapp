var React = require("react");
import ConditionQuestionsList from "./ConditionQuestionsList";
import ConditionThenQuestionsList from "./ConditionThenQuestionList";
import axios from "axios";

export default class Conditions extends React.Component {
  constructor(props) {
    super();
    this.state = {
      questions: [],
      methodType: "",
      question_id: "",
      condition_question_id: 0,
      method: "",
      scenario: "",
      value: ""
    };
  }

  componentDidMount = () => {
    let initialQuestion = [];
    const self = this;
    axios
      .get("/api/v1/questions?survey_id=" + this.props.survey_id)
      .then(function(response) {
        initialQuestion = response.data.object.map(question => {
          return question;
        });
        self.setState({
          questions: initialQuestion
        });
      })
      .catch(function(error) {
        console.log(error);
      });
  };

  saveCondition = () => {
    var self = this.state;
    axios
      .post("/api/v1/conditions", {
        question_id: self.question_id,
        condition_question_id: self.condition_question_id,
        method: self.method,
        scenario: self.scenario,
        value: self.value
      })
      .then(function(response) {
        console.log(response);
        window.location.reload();
      })
      .catch(function(error) {
        console.log(error);
      });
  };

  handleChanges = e => {
    this.setState({ methodType: e.target.value, scenario: e.target.value });
  };

  questionIdHandler = val => {
    this.setState({
      question_id: val
    });
  };

  methodHandler = val => {
    this.setState({
      method: val
    });
  };

  valueHandler = val => {
    this.setState({
      value: val
    });
  };

  conditionIdHandler = val => {
    this.setState({
      condition_question_id: val
    });
  };

  render() {
    var self = this.state;
    let thenMethod = ["skip to question", "skip to end", "hide question"];

    let thenMethodList = thenMethod.map(method => (
      <option key={method} value={method}>
        {method}
      </option>
    ));
    return (
      <div className="modal-card">
        <header className="modal-card-head">
          <p className="modal-card-title">Add New Condition Logic</p>
          <button
            type="button"
            className="delete modal--close"
            aria-label="close"
          ></button>
        </header>
        <section className="modal-card-body">
          <div className="content">
            <div className="form-group">
              <label className="label">if answer on question:</label>
              <ConditionQuestionsList
                state={this.state}
                question_id_handler={this.questionIdHandler}
                method_handler={this.methodHandler}
                value_handler={this.valueHandler}
              />{" "}
              <label className="label pt-10">then </label>
              <div className="control">
                <div className="select">
                  <select onChange={this.handleChanges}>
                    <option>Please select</option>
                    {thenMethodList}
                  </select>
                </div>
              </div>
              <div className="pt-10">
                {self.methodType == "skip to end" ? (
                  ""
                ) : (
                  <ConditionThenQuestionsList
                    state={this.state}
                    handler={this.conditionIdHandler}
                  />
                )}
              </div>
              <div className="pt-20">
                <i>
                  If answer on question ID {self.question_id} {self.method}{" "}
                  {self.value} then {self.scenario} {self.condition_question_id}
                </i>
              </div>
            </div>
          </div>
        </section>
        <footer className="modal-card-foot">
          <button
            type="submit"
            className="button is-primary"
            onClick={this.saveCondition}
          >
            Save
          </button>
          <button type="button" className="button modal--close">
            Cancel
          </button>
        </footer>
      </div>
    );
  }
}
