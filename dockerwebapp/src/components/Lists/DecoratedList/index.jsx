import { Grid } from '@mui/material';
import { Item } from './Item';

const DecoratedList = ({children, ...props}) => {
    return (
        <Grid {...props} container>
            {children}
        </Grid>
    );
}

DecoratedList.Item = Item;

export { DecoratedList };
export default DecoratedList;