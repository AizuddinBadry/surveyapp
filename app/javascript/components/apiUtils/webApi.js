import axios from "axios";
import { handleError } from "./handleError";
const API_URL = "/api/v1/";
const getHeaders = () => {
  return {
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json"
    }
  };
};
// HTTP GET Request - Returns Resolved or Rejected Promise
export const get = path => {
  return new Promise((resolve, reject) => {
    axios
      .get(path, getHeaders())
      .then(response => {
        resolve(response);
      })
      .catch(error => {
        reject(handleError(error));
      });
  });
};
// HTTP PATCH Request - Returns Resolved or Rejected Promise
export const patch = (path, data) => {
  return new Promise((resolve, reject) => {
    axios
      .patch(`${API_URL}${path}`, data, getHeaders())
      .then(response => {
        resolve(response);
      })
      .catch(error => {
        reject(handleError(error));
      });
  });
};
// HTTP POST Request - Returns Resolved or Rejected Promise
export const post = (path, data) => {
  return new Promise((resolve, reject) => {
    axios
      .post(`${API_URL}${path}`, data, getHeaders())
      .then(response => {
        resolve(response);
      })
      .catch(error => {
        reject(handleError(error));
      });
  });
};
// HTTP DELETE Request - Returns Resolved or Rejected Promise
export const del = path => {
  return new Promise((resolve, reject) => {
    axios
      .delete(`${API_URL}${path}`, getHeaders())
      .then(response => {
        resolve(response);
      })
      .catch(error => {
        reject(handleError(error));
      });
  });
};
