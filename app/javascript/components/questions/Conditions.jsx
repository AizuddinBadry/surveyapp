var React = require("react");
import ConditionQuestionsList from "./ConditionQuestionsList";
import axios from "axios";

export default class Conditions extends React.Component {
  constructor(props) {
    super();
    this.state = {
      questions: []
    };
  }

  componentDidMount = () => {
    let initialQuestion = [];
    axios
      .get("/api/v1/questions?survey_id=" + this.props.survey_id)
      .then(function(response) {
        console.log(response.data.object);
        initialQuestion = response.data.object.map(question => {
          return question;
        });
        this.setState({
          questions: initialQuestion
        });
      })
      .catch(function(error) {
        console.log(error);
      });
  };

  render() {
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
              <label>if</label>
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
