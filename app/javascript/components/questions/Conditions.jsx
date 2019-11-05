var React = require("react");
import ConditionQuestionsList from "./ConditionQuestionsList";
import axios from "axios";

export default class Conditions extends React.Component {
  constructor(props) {
    super();
    this.state = {
      questions: [],
      methodType: ""
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

  handleChanges = e => {
    this.setState({ methodType: e.target.value });
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
              <label className="label">if</label>
              <ConditionQuestionsList state={this.state} />{" "}
              <label className="label">then </label>
              <div className="control">
                <div className="select">
                  <select onChange={this.handleChanges}>
                    {thenMethodList}
                  </select>
                </div>
              </div>
              <div className="pt-10">
                {self.methodType == "skip to end" ? (
                  ""
                ) : (
                  <ConditionQuestionsList state={this.state} />
                )}
              </div>
            </div>
          </div>
        </section>
        <footer className="modal-card-foot">
          <button type="submit" className="button is-primary">
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
