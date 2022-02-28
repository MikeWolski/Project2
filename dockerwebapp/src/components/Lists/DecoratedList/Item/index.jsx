import { Grid } from '@mui/material';
import { styled } from '@mui/system';

const Decorator = styled('div')`
    display: inline-block;
    content: '';
    font-size: 1px;
    line-height: .5rem;
    padding: 1px;
    border-radius: 50%;
    vertical-align: 75%;
    background-color: currentColor;
    margin: 0px;
`;

export const Item = ({children, decorated, ...props}) => {
    return (
        <Grid {...props} item>
            <Grid container justifyContent="space-between">
                <Grid item>
                    {!!decorated ? <Decorator/> : null}
                </Grid>
                <Grid item sx={{padding: `0px 5px 0px ${!!decorated ? '5px' : '0px'}`}}>
                    {children}
                </Grid>
            </Grid>
        </Grid>
    );
}