var React = require("react");
import Main from "./types/Main";
import ListRadio from "./types/ListRadio";
import "react-trumbowyg/dist/trumbowyg.min.css";

function Step(props) {
  const step = props.option;
  const handler = props.handler;
  const group_id = props.group_id;
  if (step == 0) {
    return <Main handler={handler} />;
  } else if (step == 1) {
    return <ListRadio handler={handler} group_id={group_id} />;
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
    return (
      <Step
        option={this.state.option}
        handler={this.handler}
        group_id={this.props.group_id}
      />
    );
  }
}

export default TypeOptions;
