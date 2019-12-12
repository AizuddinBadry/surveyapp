var React = require("react");
import ConditionQuestionsList from "./ConditionQuestionsList";
import ConditionThenQuestionsList from "./ConditionThenQuestionList";
import axios from "axios";

function Link(props) {
  return (
    <div className="control">
      <div className="select">
        <select
          name="condition_link"
          onChange={props.handle_changes.bind(this, props.index)}
        >
          <option>Please select</option>
          <option value="and">AND</option>
          <option value="or">OR</option>
        </select>
      </div>
    </div>
  );
}

export default class Conditions extends React.Component {
  constructor(props) {
    super();
    this.state = {
      questions: [],
      methodType: "",
      question_id: [],
      condition_question_id: 0,
      method: [],
      scenario: [],
      value: [],
      multipleCondition: [0],
      condition_link: [""]
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
    if (this.state.methodType != "" || this.props.condition_types == "answer") {
      axios
        .post("/api/v1/conditions", {
          data: {
            question_id: self.question_id,
            condition_question_id: self.condition_question_id,
            method: self.method,
            scenario: self.scenario,
            value: self.value,
            relation: self.condition_link,
            condition_types: this.props.condition_types,
            question_answer_id: this.props.question_answer_id
          }
        })
        .then(function(response) {
          console.log(response);
          window.location.reload();
        })
        .catch(function(error) {
          console.log(error);
        });
    } else {
      alert("Please select after condition question !");
    }
  };

  handleAllChanges = (index, e) => {
    assigned = e.target.name;
    var assigned = this.state.condition_link.slice();
    assigned[index] = e.target.value;
    this.setState({ [e.target.name]: assigned });
  };

  handleChanges = e => {
    this.setState({ methodType: e.target.value, scenario: e.target.value });
  };

  questionIdHandler = (index, val) => {
    var question_id = this.state.question_id.slice();
    question_id[index] = val;
    this.setState({
      question_id: question_id
    });
  };

  methodHandler = (index, val) => {
    var method = this.state.method.slice();
    method[index] = val;
    this.setState({
      method: method
    });
  };

  valueHandler = (index, val) => {
    var value = this.state.value.slice();
    value[index] = val;
    this.setState({
      value: value
    });
  };

  conditionIdHandler = val => {
    this.setState({
      condition_question_id: val
    });
  };

  increaseOption = val => {
    var initial = this.state.multipleCondition.length;
    var newItem = parseInt(initial) + 1;
    var joinNewItem = this.state.multipleCondition.concat(newItem);
    this.setState({ multipleCondition: joinNewItem });
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
              {this.props.condition_types == "answer" ? (
                <label className="label">Display answer if:</label>
              ) : (
                <label className="label">if answer on question:</label>
              )}
              {self.multipleCondition.map((v, index) => {
                return (
                  <div key={index} className="pt-5">
                    {index > 0 ? (
                      <Link
                        handle_changes={this.handleAllChanges}
                        index={index}
                      />
                    ) : null}
                    <ConditionQuestionsList
                      index={index}
                      state={this.state}
                      question_id_handler={this.questionIdHandler}
                      method_handler={this.methodHandler}
                      value_handler={this.valueHandler}
                    />
                    <hr />
                  </div>
                );
              })}
              <div className="pt-5">
                <button
                  type="button"
                  className="button is-primary is-rounded"
                  onClick={this.increaseOption}
                >
                  <span className="icon">
                    <i className="fas fa-plus"></i>
                  </span>
                </button>
              </div>
              {this.props.condition_types == "answer" ? (
                ""
              ) : (
                <div>
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
                    {self.question_id.map((val, i) => {
                      return (
                        <div>
                          {self.condition_link[i]}
                          <p style={{ fontStyle: "italic" }}>
                            If answer on question ID {self.question_id[i]}{" "}
                            {self.method[i]} {self.value[i]}
                          </p>
                        </div>
                      );
                    })}
                    <p style={{ fontStyle: "italic" }}>
                      then {self.scenario} {self.condition_question_id}
                    </p>
                  </div>
                </div>
              )}
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
