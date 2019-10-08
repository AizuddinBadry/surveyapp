var React = require("react");
import Main from "./types/Main";
import MultipleAnswer from "./types/MultipleAnswer";
import OpenEnded from "./types/OpenEnded";
import "react-trumbowyg/dist/trumbowyg.min.css";

function Step(props) {
  const step = props.option;
  const handler = props.handler;
  const group_id = props.group_id;
  const types = props.types;
  if (step == 0) {
    return <Main handler={handler} />;
  } else if (step == 1) {
    return (
      <MultipleAnswer handler={handler} group_id={group_id} types={types} />
    );
  } else if (step == 2) {
    return <OpenEnded handler={handler} group_id={group_id} types={types} />;
  } else if (step == 3) {
    return <Mask handler={handler} group_id={group_id} types={types} />;
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
      />
    );
  }
}

export default TypeOptions;
