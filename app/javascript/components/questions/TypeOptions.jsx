var React = require("react");
import Main from "./types/Main";
import MultipleAnswer from "./types/MultipleAnswer";
import OpenEnded from "./types/OpenEnded";
import Media from "./types/Media";
import File from "./types/File";
import "react-trumbowyg/dist/trumbowyg.min.css";

function Step(props) {
  const step = props.option;
  const handler = props.handler;
  const group_id = props.group_id;
  const types = props.types;
  const survey_id = props.survey_id;
  const questions = props.questions;
  if (step == 0) {
    return <Main handler={handler} />;
  } else if (step == 1) {
    return (
      <MultipleAnswer
        handler={handler}
        group_id={group_id}
        types={types}
        survey_id={survey_id}
        questions={questions}
      />
    );
  } else if (step == 2) {
    return (
      <OpenEnded
        handler={handler}
        group_id={group_id}
        types={types}
        survey_id={survey_id}
      />
    );
  } else if (step == 3) {
    return (
      <Media
        handler={handler}
        group_id={group_id}
        types={types}
        survey_id={survey_id}
      />
    );
  }else if (step == 4) {
    return (
      <File
        handler={handler}
        group_id={group_id}
        types={types}
        survey_id={survey_id}
      />
    );
  }
}

class TypeOptions extends React.Component {
  constructor(props) {
    super(props);
    this.state = { option: 0, types: "" };
  }

  handler = (val, type) => {
    this.setState({
      option: val,
      types: type
    });
  };

  render() {
    var self = this.state;
    return (
      <Step
        option={self.option}
        handler={this.handler}
        group_id={this.props.group_id}
        types={self.types}
        survey_id={this.props.survey_id}
        questions={this.props.questions}
      />
    );
  }
}

export default TypeOptions;
