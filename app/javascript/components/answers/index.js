import React from "react";
import ReactDOM from "react-dom";
import initialData from "./initial_data";

export default class Answers extends React.Component {
  state = initialData;

  render() {
    var self = this.state;
    return this.state.columnOrder.map(columnId => {
      const column = self.columns[columnId];
      const tasks = column.taskIds.map(taskId => this.state.tasks[taskId]);
      return <Column key={column.id} column={column} tasks={tasks} />;
    });
  }
}
