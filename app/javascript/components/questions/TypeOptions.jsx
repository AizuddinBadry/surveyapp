var React = require("react");
import Main from "./types/Main";
import ListRadio from "./types/ListRadio";
import "react-trumbowyg/dist/trumbowyg.min.css";

function Step(props) {
  const step = props.option;
  const handler = props.handler;
  if (step == 0) {
    return <Main handler={handler} />;
  } else if (step == 1) {
    return <ListRadio handler={handler} />;
  }
}

class TypeOptions extends React.Component {
  constructor(props) {
    super(props);
    this.state = { option: 0 };
  }

  handler = val => {
    this.setState({
      option: val
    });
  };

  render() {
    return <Step option={this.state.option} handler={this.handler} />;
  }
}

export default TypeOptions;
