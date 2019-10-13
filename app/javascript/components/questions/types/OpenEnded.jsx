var React = require("react");
import Trumbowyg from "react-trumbowyg";
import { post } from "../../apiUtils/webApi";

export default class OpenEnded extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      values: [{ value: null }],
      status:
        '<span class="tag is-warning" id="status">This code is exists. Please use unique code for each question.</span>',
      error: false
    };
  }

  handleChange = (i, event) => {
    let values = [...this.state.values];
    values[i].value = event.target.value;
    this.setState({ values });
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
    e.preventDefault();
    const form = event.target;
    const data = new FormData(form);
    data.set("question[question_group_id]", this.props.group_id);
    data.set("question[q_type]", this.props.types);
    post("/questions", data)
      .then(data => {
        console.log(data);
        window.location.reload();
      })
      .catch(errorMessage => {
        this.setState({
          error: true
        });
      });
  };

  render() {
    var self = this.props;
    var warning;
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
            </div>
            <div className="field">
              <label className="label">Title</label>
              <Trumbowyg
                id="questionDescription"
                name="question[description]"
              />
            </div>
            <div className="field">
              <label className="label">This question is mandatory?</label>
              <input
                type="checkbox"
                name="question[mandatory]"
                id="switch"
              ></input>
              <label className="toggle" for="switch"></label>
            </div>
          </div>
        </div>
      </form>
    );
  }
}
